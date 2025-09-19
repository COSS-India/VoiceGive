import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:bhashadaan/common_widgets/audio_player/custom_audio_player.dart';
import 'package:bhashadaan/constants/app_colors.dart';
import 'package:bhashadaan/constants/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

enum RecordingState { idle, recording, stopped }

class RecordingButton extends StatefulWidget {
  const RecordingButton({super.key});

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
    await _deleteRecording();
    await recorder.dispose();
  }

  Future<void> _deleteRecording() async {
    if (recordedFilePath == null) return;
    try {
      final file = File(recordedFilePath!);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error deleting recording: $e');
    } finally {
      recordedFilePath = null;
    }
  }

  Future<String> _generateTempFilePath() async {
    final dir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${dir.path}/session_record_$timestamp.m4a';
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
      await recorder.start(
        path: tempPath,
        RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
      );
      recordedFilePath = tempPath;
      debugPrint('Recording started: $tempPath');
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await recorder.stop();
      if (path != null) {
        recordedFilePath = path;
        debugPrint('Recording saved: $path');
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  Future<void> _toggleState() async {
    if (_state == RecordingState.idle || _state == RecordingState.stopped) {
      await _deleteRecording();
      setState(() => _state = RecordingState.recording);
      _controller.repeat();
      await _startRecording();
    } else if (_state == RecordingState.recording) {
      await _stopRecording();
      setState(() => _state = RecordingState.stopped);
      _controller.stop();
    }
  }

  Widget _buildIcon() {
    switch (_state) {
      case RecordingState.idle:
        return Icon(Icons.mic, size: 40.sp, color: Colors.white);
      case RecordingState.recording:
        return Icon(Icons.stop, size: 40.sp, color: Colors.white);
      case RecordingState.stopped:
        return Icon(Icons.mic, size: 40.sp, color: Colors.white);
    }
  }

  Widget _buildText() {
    switch (_state) {
      case RecordingState.idle:
        return Text("Start Recording",
            style: GoogleFonts.notoSans(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGreen));
      case RecordingState.recording:
        return Text("Stop Recording",
            style: GoogleFonts.notoSans(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGreen));
      case RecordingState.stopped:
        return Column(
          children: [
            CustomAudioPlayer(
              filePath: recordedFilePath ?? "",
              activeColor: AppColors.darkGreen,
            ),
            SizedBox(height: 24.w),
            Text("Re-record",
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
        SizedBox(height: 36.w),
        GestureDetector(
          onTap: _toggleState,
          child: SizedBox(
            width: 60,
            height: 60,
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
                                    .withOpacity(opacity * 0.3),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                CircleAvatar(
                  radius: 36.r,
                  backgroundColor: AppColors.lightGreen,
                  child: _buildIcon(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
