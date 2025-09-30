import 'dart:io';

import 'package:bhashadaan/common_widgets/audio_player/custom_audio_player.dart';
import 'package:bhashadaan/common_widgets/image_widget.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/constants/helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

enum RecordingState { idle, recording, stopped }

class RecordingButton extends StatefulWidget {
  final Function(File?) getRecordedFile;
  final Function(bool?) isRecording;
  const RecordingButton({
    super.key,
    required this.getRecordedFile,
    required this.isRecording,
  });

  @override
  _RecordingButtonState createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  RecordingState _state = RecordingState.idle;
  final AudioRecorder recorder = AudioRecorder();
  String? recordedFilePath;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _cleanupResources();
    super.dispose();
  }

  Future<void> _cleanupResources() async {
    await recorder.dispose();
  }

  Future<String> _generateTempFilePath() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    if (kIsWeb) {
      return 'recording_$timestamp.wav';
    } else {
      final directory = await getTemporaryDirectory();
      return '${directory.path}/recording_$timestamp.wav';
    }
  }

  Future<bool> _hasRequiredPermissions() async {
    final micPermission = await Helper.requestPermission(Permission.microphone);
    final recordPermission = await recorder.hasPermission();
    return micPermission && recordPermission;
  }

  Future<void> _startRecording() async {
    if (!await _hasRequiredPermissions()) {
      Helper.showSnackBarMessage(
          // ignore: use_build_context_synchronously
          context: context,
          text: "Microphone permission not granted");
      return;
    }

    try {
      final tempPath = await _generateTempFilePath();
      debugPrint('Starting recording with path: $tempPath');
      await recorder.start(
        path: tempPath,
        RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 44100,
          bitRate: 128000,
          numChannels: 1,
        ),
      );
      recordedFilePath = tempPath;
      debugPrint('Recording started successfully');
    } catch (e) {
      debugPrint('Error starting recording: $e');
      Helper.showSnackBarMessage(
          // ignore: use_build_context_synchronously
          context: context,
          text: "Failed to start recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await recorder.stop();
      if (path != null) {
        recordedFilePath = path;

        widget.getRecordedFile(File(path));

        debugPrint('Recording saved: $path');
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
      Helper.showSnackBarMessage(
          // ignore: use_build_context_synchronously
          context: context,
          text: "Failed to stop recording: $e");
    }
  }

  Future<void> _toggleState() async {
    if (_state == RecordingState.idle || _state == RecordingState.stopped) {
      await _startRecording();
      if (mounted) {
        setState(() => _state = RecordingState.recording);
        _controller.repeat();
      }
    } else if (_state == RecordingState.recording) {
      await _stopRecording();
      if (mounted) {
        setState(() => _state = RecordingState.stopped);
        _controller.stop();
      }
    }
  }

  Widget _buildIcon() {
    switch (_state) {
      case RecordingState.idle:
        return ImageWidget(
            imageUrl: "assets/images/record.png",
            height: 240,
            width: 240,
            boxFit: BoxFit.contain);

      case RecordingState.recording:
        return Icon(Icons.stop, size: 64.sp, color: AppColors.appBarBackground);
      case RecordingState.stopped:
        return ImageWidget(
            imageUrl: "assets/images/record.png",
            height: 240,
            width: 240,
            boxFit: BoxFit.contain);
    }
  }

  Widget _buildText() {
    switch (_state) {
      case RecordingState.idle:
        return Text(AppLocalizations.of(context)!.startRecording,
            style: GoogleFonts.notoSans(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGreen));
      case RecordingState.recording:
        return Text(AppLocalizations.of(context)!.stopRecording,
            style: GoogleFonts.notoSans(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGreen));
      case RecordingState.stopped:
        return Column(
          children: [
            if (recordedFilePath != null) ...[
              SizedBox(height: 8.w),
              CustomAudioPlayer(
                filePath: recordedFilePath!,
                activeColor: AppColors.darkGreen,
              ),
            ] else ...[
              Text(
                "No recording available",
                style: GoogleFonts.notoSans(
                  fontSize: 12.sp,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 8.w),
            ],
            SizedBox(height: 16.w),
            Text(AppLocalizations.of(context)!.reRecord,
                style: GoogleFonts.notoSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGreen)),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildText(),
        SizedBox(height: 12.w),
        GestureDetector(
          onTap: _toggleState,
          child: SizedBox(
            width: 240,
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_state == RecordingState.recording)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Stack(
                        children: List.generate(3, (index) {
                          final progress =
                              (_controller.value + index / 3) % 1.0;
                          final scale = 1.0 + progress * 2.0;
                          final opacity = (1 - progress).clamp(0.0, 1.0);

                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.lightGreen
                                    .withValues(alpha: opacity * 0.3),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                _buildIcon(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
