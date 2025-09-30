class UserModel {
    String userId;
    String firstName;
    String lastName;
    String mobileNo;
    String email;
    String ageGroup;
    String gender;
    String country;
    String state;
    String district;
    String preferredLanguage;
    int contributionCount;
    int validationCount;
    bool certificateEarned;
    String certificateId;
    bool consentGiven;
    DateTime consentTimestamp;
    DateTime createdAt;
    DateTime updatedAt;

    UserModel({
        required this.userId,
        required this.firstName,
        required this.lastName,
        required this.mobileNo,
        required this.email,
        required this.ageGroup,
        required this.gender,
        required this.country,
        required this.state,
        required this.district,
        required this.preferredLanguage,
        required this.contributionCount,
        required this.validationCount,
        required this.certificateEarned,
        required this.certificateId,
        required this.consentGiven,
        required this.consentTimestamp,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNo: json["mobileNo"],
        email: json["email"],
        ageGroup: json["ageGroup"],
        gender: json["gender"],
        country: json["country"],
        state: json["state"],
        district: json["district"],
        preferredLanguage: json["preferredLanguage"],
        contributionCount: json["contributionCount"],
        validationCount: json["validationCount"],
        certificateEarned: json["certificateEarned"],
        certificateId: json["certificateId"],
        consentGiven: json["consentGiven"],
        consentTimestamp: DateTime.parse(json["consentTimestamp"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNo": mobileNo,
        "email": email,
        "ageGroup": ageGroup,
        "gender": gender,
        "country": country,
        "state": state,
        "district": district,
        "preferredLanguage": preferredLanguage,
        "contributionCount": contributionCount,
        "validationCount": validationCount,
        "certificateEarned": certificateEarned,
        "certificateId": certificateId,
        "consentGiven": consentGiven,
        "consentTimestamp": consentTimestamp.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
