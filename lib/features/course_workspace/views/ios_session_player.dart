import 'package:cad_code_academy/features/course_workspace/views/session_video_player_view.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../core/theme/app_theme.dart';

class IosSessionPlayer extends StatefulWidget {
  final String driveUrl;
  final String title;

  const IosSessionPlayer({super.key, required this.driveUrl, required this.title});

  @override
  State<IosSessionPlayer> createState() => IosSessionPlayerState();
}

class IosSessionPlayerState extends State<IosSessionPlayer> {
  VideoPlayerController? _vpc;
  ChewieController? _chewie;

  bool _isLoading = true;
  bool _hasError = false;
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
    return Uri.tryParse(url)?.queryParameters['id'] ?? '';
  }

  Future<void> _start() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    await _disposeControllers();

    final fileId = _extractFileId(widget.driveUrl);
    if (fileId.isEmpty) {
      _fail('رابط الفيديو غير صحيح');
      return;
    }

    try {
      final stream = await resolveDriveStream(fileId);
      if (!mounted) return;

      final vpc = VideoPlayerController.networkUrl(
        Uri.parse(stream.url),
        httpHeaders: stream.headers,
      );
      _vpc = vpc;
      await vpc.initialize();
      if (!mounted) return;

      _chewie = ChewieController(
        videoPlayerController: vpc,
        autoPlay: true,
        aspectRatio: vpc.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppTheme.primaryGoldLight,
          handleColor: AppTheme.primaryGoldLight,
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white38,
        ),
      );
      setState(() => _isLoading = false);
    } catch (e) {
      debugPrint('IOS VIDEO ERROR: $e');
      _fail('الفيديو مش متوافق مع جهازك. جرب تفتحه في المتصفح.\n$e');
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

  Future<void> _disposeControllers() async {
    _chewie?.dispose();
    _chewie = null;
    await _vpc?.dispose();
    _vpc = null;
  }

  @override
  void dispose() {
    _chewie?.dispose();
    _vpc?.dispose();
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
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: AppTheme.primaryGoldLight,
                strokeWidth: 3,
              ),
              SizedBox(height: 24.h),
              Text(
                'جاري معالجة الفيديو وبدء البث',
                style: TextStyle(color: Colors.white70, fontSize: 16.sp),
              ),
            ],
          )
              : _hasError
              ? _buildError()
              : Chewie(controller: _chewie!),
        ),
      ),
    );
  }

  Widget _buildError() {
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