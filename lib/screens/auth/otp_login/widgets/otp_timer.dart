import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';

class OtpTimer extends StatefulWidget {
  final VoidCallback? onResend;
  final int initialSeconds;

  const OtpTimer({
    super.key,
    this.onResend,
    this.initialSeconds = 180, // 3 minutes default
  });

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  late Timer _timer;
  late int _seconds;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _seconds = widget.initialSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer.cancel();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = widget.initialSeconds;
      _canResend = false;
    });
    _startTimer();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_canResend) ...[
          Text(
            _formatTime(_seconds),
            style: GoogleFonts.notoSans(
              color: AppColors.lightGreen,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
        ],
        if (_canResend) ...[
          GestureDetector(
            onTap: () {
              widget.onResend?.call();
              _resetTimer();
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "I didn't receive any OTP. ",
                    style: GoogleFonts.notoSans(
                      color: AppColors.greys60,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: "RESEND",
                    style: GoogleFonts.notoSans(
                      color: AppColors.lightGreen,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
