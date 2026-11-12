import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'ios_session_player.dart';
import 'media_kit_session_player.dart';

const _userAgent =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
    '(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';

class DriveStream {
  final String url;
  final Map<String, String> headers;
  const DriveStream(this.url, this.headers);
}

Future<DriveStream> resolveDriveStream(String fileId) async {
  final cookies = <String, String>{};
  String cookieHeader() =>
      cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');

  var url =
      'https://drive.usercontent.google.com/download?id=$fileId&export=download&confirm=t';

  final client = HttpClient()
    ..connectionTimeout = const Duration(seconds: 15);

  try {
    for (var i = 0; i < 6; i++) {
      final req = await client.getUrl(Uri.parse(url));
      req.followRedirects = false;
      req.headers.set('User-Agent', _userAgent);
      if (cookies.isNotEmpty) req.headers.set('Cookie', cookieHeader());

      final res = await req.close();
      for (final c in res.cookies) {
        cookies[c.name] = c.value;
      }

      // Redirect
      if (const [301, 302, 303, 307, 308].contains(res.statusCode)) {
        await res.drain();
        final loc = res.headers.value('location');
        if (loc == null) throw 'Redirect without location';
        url = Uri.parse(url).resolve(loc).toString();
        continue;
      }

      if (res.statusCode != 200) {
        await res.drain();
        throw 'HTTP ${res.statusCode}';
      }

      final mime = res.headers.contentType?.mimeType ?? '';

      // Real file -> done (client.close(force) in finally aborts the body).
      if (!mime.contains('text/html')) {
        return DriveStream(url, {
          'User-Agent': _userAgent,
          if (cookies.isNotEmpty) 'Cookie': cookieHeader(),
        });
      }

      // HTML -> virus-scan / confirm page. Read the form and submit it.
      final body = await utf8.decodeStream(res);
      final action =
      RegExp(r'<form[^>]+action="([^"]+)"').firstMatch(body)?.group(1);

      if (action == null) {
        final title =
            RegExp(r'<title>(.*?)</title>', caseSensitive: false)
                .firstMatch(body)
                ?.group(1) ??
                'No title';
        throw 'Drive returned a page: [$title]. '
            'Make sure the file is shared as "Anyone with the link".';
      }

      final params = <String, String>{};
      for (final m
      in RegExp(r'<input[^>]+type="hidden"[^>]*>').allMatches(body)) {
        final tag = m.group(0)!;
        final name = RegExp(r'name="([^"]*)"').firstMatch(tag)?.group(1);
        final value = RegExp(r'value="([^"]*)"').firstMatch(tag)?.group(1);
        if (name != null) {
          params[name] = (value ?? '').replaceAll('&amp;', '&');
        }
      }

      final base = Uri.parse(action.replaceAll('&amp;', '&'));
      url = base
          .replace(queryParameters: {...base.queryParameters, ...params})
          .toString();
    }
    throw 'Too many redirects';
  } finally {
    client.close(force: true);
  }
}


class SessionVideoPlayerView extends StatelessWidget {
  final String driveUrl;
  final String title;

  const SessionVideoPlayerView({
    super.key,
    required this.driveUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return IosSessionPlayer(driveUrl: driveUrl, title: title);
    }
    return MediaKitSessionPlayer(driveUrl: driveUrl, title: title);
  }
}