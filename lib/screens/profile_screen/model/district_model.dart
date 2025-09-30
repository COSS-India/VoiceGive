class DistrictModel {
    String districtId;
    String districtName;

    DistrictModel({
        required this.districtId,
        required this.districtName,
    });

    factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        districtId: json['districtId']??'',
        districtName: json['districtName']??'',
    );

    Map<String, dynamic> toJson() => {
        'districtId': districtId,
        'districtName': districtName,
    };
}