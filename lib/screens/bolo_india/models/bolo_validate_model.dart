class ValidationItem {
  final String contributionId;
  final String sentenceId;
  final String text;
  final String audioUrl;
  final int duration;
  final int sequenceNumber;

  ValidationItem({
    required this.contributionId,
    required this.sentenceId,
    required this.text,
    required this.audioUrl,
    required this.duration,
    required this.sequenceNumber,
  });

  factory ValidationItem.fromJson(Map<String, dynamic> json) {
    return ValidationItem(
      contributionId: json['contributionId'] as String,
      sentenceId: json['sentenceId'] as String,
      text: json['text'] as String,
      audioUrl: json['audioUrl'] as String,
      duration: json['duration'] as int,
      sequenceNumber: json['sequenceNumber'] as int,
    );
  }
}

class ValidationQueueModel {
  final String sessionId;
  final String language;
  final List<ValidationItem> validationItems;

  ValidationQueueModel({
    required this.sessionId,
    required this.language,
    required this.validationItems,
  });

  factory ValidationQueueModel.fromJson(Map<String, dynamic> json) {
    return ValidationQueueModel(
      sessionId: json['sessionId'] as String,
      language: json['language'] as String,
      validationItems: (json['validationItems'] as List)
          .map((e) => ValidationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
