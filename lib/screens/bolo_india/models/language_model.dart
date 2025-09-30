class LanguageModel {
  final String languageCode;
  final String languageName;
  final String nativeName;
  final bool isActive;
  final String region;
  final String speakers;

  LanguageModel({
    required this.languageCode,
    required this.languageName,
    required this.nativeName,
    required this.isActive,
    required this.region,
    required this.speakers,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      languageCode: json['languageCode'] as String,
      languageName: json['languageName'] as String,
      nativeName: json['nativeName'] as String,
      isActive: json['isActive'] as bool,
      region: json['region'] as String,
      speakers: json['speakers'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'languageCode': languageCode,
        'languageName': languageName,
        'nativeName': nativeName,
        'isActive': isActive,
        'region': region,
        'speakers': speakers,
      };
}
