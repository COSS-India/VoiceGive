import 'dart:async';

import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum AudioPlayerButtonState { idle, playing, paused, replay, completed }

class AudioPlayerButtons extends StatefulWidget {
  final Function(AudioPlayerButtonState?) playerStatus;

  const AudioPlayerButtons({super.key, required this.playerStatus});

  @override
  State<AudioPlayerButtons> createState() => _AudioPlayerButtonsState();
}

class _AudioPlayerButtonsState extends State<AudioPlayerButtons>
    with SingleTickerProviderStateMixin {
  static const int audioDurationSeconds = 10;
  AudioPlayerButtonState _state = AudioPlayerButtonState.idle;
  late AnimationController _controller;
  Timer? _playbackTimer;
  int _remainingSeconds = audioDurationSeconds;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _playbackTimer?.cancel();
    super.dispose();
  }

  void _startPlayback() {
    _controller.repeat();
    _remainingSeconds = audioDurationSeconds;
    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds <= 0) {
          timer.cancel();
          _controller.stop();
          _state = AudioPlayerButtonState.replay;
          widget.playerStatus.call(_state);
        }
      });
    });
  }

  void _pausePlayback() {
    _controller.stop();
    _playbackTimer?.cancel();
  }

  void _resumePlayback() {
    _controller.repeat();
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds <= 0) {
          timer.cancel();
          _controller.stop();
          _state = AudioPlayerButtonState.replay;
          widget.playerStatus.call(_state);
        }
      });
    });
  }

  void _toggleState() {
    setState(() {
      switch (_state) {
        case AudioPlayerButtonState.idle:
          _state = AudioPlayerButtonState.playing;
          _startPlayback();
          break;
        case AudioPlayerButtonState.playing:
          _state = AudioPlayerButtonState.paused;
          _pausePlayback();
          break;
        case AudioPlayerButtonState.paused:
          _state = AudioPlayerButtonState.playing;
          _resumePlayback();
          break;
        case AudioPlayerButtonState.replay || AudioPlayerButtonState.completed:
          _state = AudioPlayerButtonState.playing;
          _startPlayback();
          break;
      }
    });
    widget.playerStatus.call(_state);
  }

  TextStyle get _textStyle => GoogleFonts.notoSans(
      fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.darkGreen);

  Widget _buildPulsingIndicator() {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_state == AudioPlayerButtonState.playing)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: List.generate(3, (index) {
                    final progress = (_controller.value + index / 3) % 1.0;
                    final scale = 1.0 + progress * 2.0;
                    final opacity = (1 - progress).clamp(0.0, 1.0);

                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              AppColors.lightGreen.withOpacity(opacity * 0.3),
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
            child: Icon(Icons.pause, size: 40.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    String text;
    IconData? icon;
    Widget buttonContent;

    switch (_state) {
      case AudioPlayerButtonState.idle:
        text = "Play Recording";
        icon = Icons.play_arrow;
        buttonContent = CircleAvatar(
            radius: 36.r,
            backgroundColor: AppColors.lightGreen.withOpacity(0.9),
            child: Icon(icon, size: 40.sp, color: Colors.white));
        break;
      case AudioPlayerButtonState.playing:
        text = "Pause Recording";
        buttonContent = _buildPulsingIndicator();
        break;
      case AudioPlayerButtonState.paused:
        text = "Resume Recording";
        icon = Icons.play_arrow;
        buttonContent = CircleAvatar(
            radius: 36.r,
            backgroundColor: AppColors.lightGreen.withOpacity(0.9),
            child: Icon(icon, size: 40.sp, color: Colors.white));
        break;
      case AudioPlayerButtonState.replay || AudioPlayerButtonState.completed:
        text = "Replay Recording";
        icon = Icons.replay;
        buttonContent = CircleAvatar(
            radius: 36.r,
            backgroundColor: AppColors.lightGreen.withOpacity(0.9),
            child: Icon(icon, size: 40.sp, color: Colors.white));
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: _textStyle),
        SizedBox(height: 24.h),
        GestureDetector(
          onTap: _toggleState,
          child: buttonContent,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
