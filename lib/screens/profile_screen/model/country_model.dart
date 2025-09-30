class CountryModel {
    String countryId;
    String countryName;
    String countryCode;

    CountryModel({
        required this.countryId,
        required this.countryName,
        required this.countryCode,
    });

    factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        countryId: json['countryId']??'',
        countryName: json['countryName']??'',
        countryCode: json['countryCode']??'',
    );

    Map<String, dynamic> toJson() => {
        'countryId': countryId,
        'countryName': countryName,
        'countryCode': countryCode,
    };
}
