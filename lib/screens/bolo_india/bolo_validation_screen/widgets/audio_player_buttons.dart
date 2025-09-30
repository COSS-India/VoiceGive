import 'dart:async';

import 'package:bhashadaan/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum AudioPlayerButtonState { idle, playing, paused, replay, completed }

class AudioPlayerButtons extends StatefulWidget {
  final String audioUrl;
  final Function(AudioPlayerButtonState?) playerStatus;

  const AudioPlayerButtons(
      {super.key, required this.playerStatus, required this.audioUrl});

  @override
  State<AudioPlayerButtons> createState() => _AudioPlayerButtonsState();
}

class _AudioPlayerButtonsState extends State<AudioPlayerButtons>
    with SingleTickerProviderStateMixin {
  static const int audioDurationSeconds = 3;
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

  @override
  void didUpdateWidget(covariant AudioPlayerButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioUrl != widget.audioUrl) {
      setState(() {
        _state = AudioPlayerButtonState.idle;
        _controller.reset();
        _playbackTimer?.cancel();
        _remainingSeconds = audioDurationSeconds;
      });
    }
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
    const double overallWidth = 280;
    const double overallHeight = 154;
    const double innerDiameter = 77; // circle holding the control
    const double playIconSize = 40; // maintain consistency for pause too

    return SizedBox(
      width: overallWidth,
      height: overallHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_state == AudioPlayerButtonState.playing)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: List.generate(2, (index) {
                    final progress = (_controller.value + index / 3) % 1.0;
                    final scale = 1.0 + progress * 0.8;
                    final opacity = (1 - progress).clamp(0.0, 1.0);
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: innerDiameter + 18,
                        height: innerDiameter + 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromRGBO(39, 200, 84, 1)
                              .withOpacity(opacity * 0.2),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          // Inner solid circle with pause icon
          Container(
            width: innerDiameter,
            height: innerDiameter,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(39, 200, 84, 1),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.pause, size: playIconSize, color: Colors.white),
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
        icon = null;
        buttonContent = SizedBox(
          width: 280,
          height: 154,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // outer lighter circle
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(39, 200, 84, 1).withOpacity(0.2),
                ),
              ),
              // inner solid circle
              Container(
                width: 77,
                height: 77,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(39, 200, 84, 1),
                ),
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: const Offset(4, 0),
                  child: Image.asset(
                    'assets/images/play_button.png',
                    width: 52,
                    height: 52,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case AudioPlayerButtonState.playing:
        text = "Pause Recording";
        buttonContent = _buildPulsingIndicator();
        break;
      case AudioPlayerButtonState.paused:
        text = "Resume Recording";
        icon = null;
        buttonContent = SizedBox(
          width: 280,
          height: 154,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(39, 200, 84, 1).withOpacity(0.2),
                ),
              ),
              Container(
                width: 77,
                height: 77,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(39, 200, 84, 1),
                ),
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: const Offset(4, 0),
                  child: Image.asset(
                    'assets/images/play_button.png',
                    width: 52,
                    height: 52,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
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
