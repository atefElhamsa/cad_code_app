import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'dart:io';
import 'dart:convert';

import '../../../../core/theme/app_theme.dart';

class DirectStreamResult {
  final String url;
  final String cookie;
  final String error;
  DirectStreamResult(this.url, this.cookie, {this.error = ''});
}

class SessionVideoPlayerView extends StatefulWidget {
  final String driveUrl;
  final String title;

  const SessionVideoPlayerView({
    super.key,
    required this.driveUrl,
    required this.title,
  });

  @override
  State<SessionVideoPlayerView> createState() => _SessionVideoPlayerViewState();
}

class _SessionVideoPlayerViewState extends State<SessionVideoPlayerView> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _hasError = false;
  String _debugMessage = '';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  String _extractFileId(String url) {
    if (url.contains('/file/d/')) {
      final parts = url.split('/file/d/');
      if (parts.length > 1) {
        return parts[1].split('/')[0];
      }
    }
    final uri = Uri.tryParse(url);
    if (uri != null && uri.queryParameters.containsKey('id')) {
      return uri.queryParameters['id']!;
    }
    return '';
  }

  Future<DirectStreamResult> _getDirectStreamUrl(String fileId) async {
    String currentUrl = 'https://docs.google.com/uc?export=download&id=$fileId';
    String currentCookie = '';
    final userAgent =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';

    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 15);

      int redirectCount = 0;
      while (redirectCount < 5) {
        final request = await client.getUrl(Uri.parse(currentUrl));
        request.followRedirects = false;
        request.headers.set('User-Agent', userAgent);
        if (currentCookie.isNotEmpty) {
          request.headers.set('Cookie', currentCookie);
        }

        final response = await request.close();

        // Update cookie if Google sets a new one
        final newCookies = response.headers['set-cookie']?.join('; ') ?? '';
        if (newCookies.isNotEmpty) {
          currentCookie = newCookies;
        }

        if (response.statusCode == 301 ||
            response.statusCode == 302 ||
            response.statusCode == 303) {
          final location = response.headers.value('location');
          if (location != null) {
            currentUrl = location;
            // If the redirect location is the actual Google CDN, we have successfully bypassed everything!
            if (currentUrl.contains('googleusercontent.com')) {
              client.close();
              return DirectStreamResult(currentUrl, currentCookie);
            }
            redirectCount++;
            continue; // Loop again to follow the redirect
          }
        } else if (response.statusCode == 200) {
          final contentType = response.headers.contentType?.mimeType ?? '';

          if (contentType.contains('text/html')) {
            // If we hit a 200 OK HTML, it's likely the Virus Scan page or a Login page.
            final bytes = await response.fold<List<int>>(
              <int>[],
              (prev, elem) => prev..addAll(elem),
            );
            final responseBody = utf8.decode(bytes, allowMalformed: true);

            // Google Drive 2024 Update: The download form now uses a 'uuid' and a new domain.
            final uuidRegex = RegExp(
              r'name="uuid"\s+value="([^"]+)"',
              caseSensitive: false,
            );
            final uuidMatch = uuidRegex.firstMatch(responseBody);

            if (uuidMatch != null) {
              final uuid = uuidMatch.group(1)!;
              currentUrl =
                  'https://drive.usercontent.google.com/download?id=$fileId&export=download&confirm=t&uuid=$uuid';
              redirectCount++;
              continue;
            }

            // Fallback 1: Extract token from cookies (legacy method)
            final cookieRegex = RegExp(
              r'download_warning_([a-zA-Z0-9-_]+)',
              caseSensitive: false,
            );
            final cookieMatch = cookieRegex.firstMatch(currentCookie);

            if (cookieMatch != null) {
              final confirmToken = cookieMatch.group(1)!;
              currentUrl =
                  'https://docs.google.com/uc?export=download&id=$fileId&confirm=$confirmToken';
              redirectCount++;
              continue;
            }

            // Fallback 2: Extract confirm token from HTML (legacy method)
            final htmlRegex = RegExp(
              r'confirm=([a-zA-Z0-9-_]+)',
              caseSensitive: false,
            );
            final htmlMatch = htmlRegex.firstMatch(responseBody);

            if (htmlMatch != null) {
              final confirmToken = htmlMatch.group(1)!;
              currentUrl =
                  'https://docs.google.com/uc?export=download&id=$fileId&confirm=$confirmToken';
              redirectCount++;
              continue;
            }

            // If we reach here, it's a completely unknown HTML page (e.g. Login or Access Denied)
            client.close();

            final titleRegex = RegExp(
              r'<title>(.*?)<\/title>',
              caseSensitive: false,
            );
            final titleMatch = titleRegex.firstMatch(responseBody);
            final pageTitle = titleMatch != null
                ? titleMatch.group(1)
                : 'No Title';

            return DirectStreamResult(
              currentUrl,
              currentCookie,
              error:
                  'HTML: [$pageTitle] Failed to extract download token. Is the video private?',
            );
          } else {
            client.close();
            return DirectStreamResult(currentUrl, currentCookie);
          }
        } else {
          client.close();
          return DirectStreamResult(
            currentUrl,
            currentCookie,
            error: 'Unexpected status code: ${response.statusCode}',
          );
        }
      }

      client.close();
      return DirectStreamResult(
        currentUrl,
        currentCookie,
        error: 'Too many redirects',
      );
    } catch (e) {
      return DirectStreamResult(
        currentUrl,
        currentCookie,
        error: 'Exception: $e',
      );
    }
  }

  Future<void> _initializePlayer() async {
    final fileId = _extractFileId(widget.driveUrl);

    if (fileId.isEmpty) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _debugMessage = 'File ID is empty';
        });
      }
      return;
    }

    final result = await _getDirectStreamUrl(fileId);

    // If the scraper returned an error, show it!
    if (result.error.isNotEmpty) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _debugMessage = result.error;
        });
      }
      return;
    }

    if (!mounted) return;

    final userAgent =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';
    final headers = {'User-Agent': userAgent};
    if (result.cookie.isNotEmpty) {
      headers['Cookie'] = result.cookie;
    }

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(result.url),
      httpHeaders: headers,
    );

    try {
      await _videoPlayerController!.initialize();

      if (!mounted) return;

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppTheme.primaryGoldLight,
          handleColor: AppTheme.primaryGoldLight,
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white38,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'عذراً، فشل تشغيل الفيديو',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
          _debugMessage = 'VideoPlayer init failed: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? _buildLoadingState()
              : _hasError
              ? _buildErrorState(_debugMessage)
              : Chewie(controller: _chewieController!),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: AppTheme.primaryGoldLight,
          strokeWidth: 3,
        ),
        const SizedBox(height: 24),
        const Text(
          'جاري معالجة الفيديو وبدء البث',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ أثناء تحميل الفيديو',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _debugMessage,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
