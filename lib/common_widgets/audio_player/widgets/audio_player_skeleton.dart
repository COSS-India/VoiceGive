import 'package:bhashadaan/common_widgets/container_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioPlayerSkeleton extends StatefulWidget {
  const AudioPlayerSkeleton({super.key});

  @override
  State<AudioPlayerSkeleton> createState() => _AudioPlayerSkeletonState();
}

class _AudioPlayerSkeletonState extends State<AudioPlayerSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40).r,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContainerSkeleton(width: 40, height: 40, radius: 20),
          ContainerSkeleton(width: 40, height: 20, radius: 2),
          ContainerSkeleton(width: 0.4.sw, height: 5, radius: 2),
          ContainerSkeleton(width: 40, height: 20, radius: 2),
        ],
      ),
    );
  }
}
