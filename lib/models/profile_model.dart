class ProfileData {
  final String firstName;
  final String lastName;
  final String? dateOfBirth;
  final String gender;
  final String email;
  final String mobileNo;
  final String preferredLanguage;
  final int district;
  final int state;
  final int country;
  final int age;
  final String? filePath;

  ProfileData({
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    required this.gender,
    required this.email,
    required this.mobileNo,
    required this.preferredLanguage,
    required this.district,
    required this.state,
    required this.country,
    required this.age,
    this.filePath,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      preferredLanguage: json['preferredLanguage'] ?? '',
      district: json['district'] ?? 0,
      state: json['state'] ?? 0,
      country: json['country'] ?? 0,
      age: json['age'] ?? 0,
      filePath: json['filePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'email': email,
      'mobileNo': mobileNo,
      'preferredLanguage': preferredLanguage,
      'district': district,
      'state': state,
      'country': country,
      'age': age,
      'filePath': filePath,
    };
  }

  ProfileData copyWith({
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? email,
    String? mobileNo,
    String? preferredLanguage,
    int? district,
    int? state,
    int? country,
    int? age,
    String? filePath,
  }) {
    return ProfileData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      mobileNo: mobileNo ?? this.mobileNo,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      district: district ?? this.district,
      state: state ?? this.state,
      country: country ?? this.country,
      age: age ?? this.age,
      filePath: filePath ?? this.filePath,
    );
  }
}

class ProfileResponse {
  final String message;
  final ProfileData data;

  ProfileResponse({
    required this.message,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      message: json['message'] ?? '',
      data: ProfileData.fromJson(json['data'] ?? {}),
    );
  }
}

class UpdateProfileRequest {
  final String? profilePhoto;
  final String firstName;
  final int age;
  final String gender;
  final String mobileNo;
  final int country;
  final int district;
  final String preferredLanguage;
  final int userNum;
  final String email;

  UpdateProfileRequest({
    this.profilePhoto,
    required this.firstName,
    required this.age,
    required this.gender,
    required this.mobileNo,
    required this.country,
    required this.district,
    required this.preferredLanguage,
    required this.userNum,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'profile_photo': profilePhoto,
      'firstName': firstName,
      'age': age,
      'gender': gender,
      'mobileNo': mobileNo,
      'country': country,
      'district': district,
      'preferredLanguage': preferredLanguage,
      'userNum': userNum,
      'email': email,
    };
  }
}

class UpdateProfileResponse {
  final String message;
  final ProfileData result;

  UpdateProfileResponse({
    required this.message,
    required this.result,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      message: json['message'] ?? '',
      result: ProfileData.fromJson(json['result'] ?? {}),
    );
  }
}
