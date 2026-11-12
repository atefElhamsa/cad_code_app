import 'dart:async';

import 'package:cad_code_academy/features/course_workspace/views/session_video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';

class MediaKitSessionPlayer extends StatefulWidget {
  final String driveUrl;
  final String title;

  const MediaKitSessionPlayer({
    super.key,
    required this.driveUrl,
    required this.title,
  });

  @override
  State<MediaKitSessionPlayer> createState() => _MediaKitSessionPlayerState();
}

class _MediaKitSessionPlayerState extends State<MediaKitSessionPlayer> {
  Player? _player;
  VideoController? _video;
  StreamSubscription<String>? _errorSub;
  DriveStream? _stream;

  bool _isLoading = true;
  bool _hasError = false;
  bool _retriedSoftware = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _start();
  }

  String _extractFileId(String url) {
    if (url.contains('/file/d/')) {
      final parts = url.split('/file/d/');
      if (parts.length > 1) return parts[1].split('/')[0];
    }
    final uri = Uri.tryParse(url);
    return uri?.queryParameters['id'] ?? '';
  }

  Future<void> _start() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _retriedSoftware = false;
    });

    final fileId = _extractFileId(widget.driveUrl);
    if (fileId.isEmpty) {
      _fail('رابط الفيديو غير صحيح');
      return;
    }

    try {
      _stream = await resolveDriveStream(fileId);
    } catch (e) {
      _fail('تعذر الوصول للفيديو. تأكد من الاتصال بالإنترنت.\n$e');
      return;
    }

    if (!mounted) return;
    await _open(hardware: true);
  }

  Future<void> _open({required bool hardware}) async {
    await _disposePlayer();
    if (!mounted) return;

    final player = Player(
      configuration: const PlayerConfiguration(bufferSize: 64 * 1024 * 1024),
    );
    final video = VideoController(
      player,
      configuration: VideoControllerConfiguration(
        enableHardwareAcceleration: hardware,
      ),
    );

    _player = player;
    _video = video;

    // If the hardware decoder fails, retry once in software mode (ffmpeg).
    _errorSub = player.stream.error.listen((_) {
      if (hardware && !_retriedSoftware) {
        _retriedSoftware = true;
        _open(hardware: false);
      } else {
        _fail('الفيديو مش متوافق مع جهازك. جرب تفتحه في المتصفح.');
      }
    });

    try {
      await player.open(
        Media(_stream!.url, httpHeaders: _stream!.headers),
        play: true,
      );
      if (mounted) setState(() => _isLoading = false);
    } catch (_) {
      if (hardware && !_retriedSoftware) {
        _retriedSoftware = true;
        await _open(hardware: false);
      } else {
        _fail('فشل تشغيل الفيديو.');
      }
    }
  }

  void _fail(String message) {
    if (!mounted) return;
    setState(() {
      _hasError = true;
      _isLoading = false;
      _errorMessage = message;
    });
  }

  Future<void> _disposePlayer() async {
    await _errorSub?.cancel();
    _errorSub = null;
    final p = _player;
    _player = null;
    _video = null;
    await p?.dispose();
  }

  @override
  void dispose() {
    _errorSub?.cancel();
    _player?.dispose();
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? _buildLoadingState()
              : _hasError
              ? _buildErrorState()
              : _buildPlayer(),
        ),
      ),
    );
  }

  Widget _buildPlayer() {
    const theme = MaterialVideoControlsThemeData(
      seekBarPositionColor: AppTheme.primaryGoldLight,
      seekBarThumbColor: AppTheme.primaryGoldLight,
      seekBarColor: Colors.white24,
      seekBarBufferColor: Colors.white38,
    );
    return MaterialVideoControlsTheme(
      normal: theme,
      fullscreen: theme,
      child: Video(controller: _video!),
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
        SizedBox(height: 24.h),
        Text(
          'جاري معالجة الفيديو وبدء البث',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
          SizedBox(height: 16.h),
          Text(
            'حدث خطأ أثناء تحميل الفيديو',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            _errorMessage,
            style: TextStyle(color: Colors.white54, fontSize: 13.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _start,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة المحاولة'),
              ),
              OutlinedButton.icon(
                onPressed: () => launchUrl(
                  Uri.parse(widget.driveUrl),
                  mode: LaunchMode.externalApplication,
                ),
                icon: const Icon(Icons.open_in_browser),
                label: const Text('افتح في المتصفح'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
