class LanguageModel {
    String languageCode;
    String languageName;
    String nativeName;
    bool isActive;
    String region;
    String speakers;

    LanguageModel({
        required this.languageCode,
        required this.languageName,
        required this.nativeName,
        required this.isActive,
        required this.region,
        required this.speakers,
    });

    factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        languageCode: json["languageCode"],
        languageName: json["languageName"],
        nativeName: json["nativeName"],
        isActive: json["isActive"],
        region: json["region"],
        speakers: json["speakers"],
    );

    Map<String, dynamic> toJson() => {
        "languageCode": languageCode,
        "languageName": languageName,
        "nativeName": nativeName,
        "isActive": isActive,
        "region": region,
        "speakers": speakers,
    };
}