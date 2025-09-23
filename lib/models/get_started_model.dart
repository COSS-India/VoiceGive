import 'package:flutter/material.dart';

class GetStartedModel {
  final String title;
  final String illustrationImageUrl;
  final List<GetStartedInstruction> instructions;

  GetStartedModel({
    required this.title,
    required this.illustrationImageUrl,
    required this.instructions,
  });
}

class GetStartedInstruction {
  final String title;
  final String description;
  final String iconPath;

  GetStartedInstruction({
    required this.title,
    required this.description,
    required this.iconPath,
  });
}
