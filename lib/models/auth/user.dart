/// User model representing authenticated user data
class User {
  final int userId;
  final String firstName;
  final String lastName;
  final String userName;
  final int? age;
  final String? gender;
  final String? organization;
  final int? organizationId;
  final String? motherTongue;
  final String? mobileNo;
  final String email;
  final String role;
  final String roleName;
  final String? country;
  final String? district;
  final int platformId;

  const User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    this.age,
    this.gender,
    this.organization,
    this.organizationId,
    this.motherTongue,
    this.mobileNo,
    required this.email,
    required this.role,
    required this.roleName,
    this.country,
    this.district,
    required this.platformId,
  });

  /// Create User from JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] as int? ?? 0,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      organization: json['organization'] as String?,
      organizationId: json['organizationId'] as int?,
      motherTongue: json['motherTongue'] as String?,
      mobileNo: json['mobileNo'] as String?,
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
      roleName: json['roleName'] as String? ?? '',
      country: json['country'] as String?,
      district: json['district'] as String?,
      platformId: json['platformId'] as int? ?? 1,
    );
  }

  /// Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'age': age,
      'gender': gender,
      'organization': organization,
      'organizationId': organizationId,
      'motherTongue': motherTongue,
      'mobileNo': mobileNo,
      'email': email,
      'role': role,
      'roleName': roleName,
      'country': country,
      'district': district,
      'platformId': platformId,
    };
  }

  /// Get full name
  String get fullName => '$firstName $lastName';

  /// Check if user has complete profile
  bool get hasCompleteProfile {
    return age != null &&
        gender != null &&
        motherTongue != null &&
        mobileNo != null &&
        country != null &&
        district != null;
  }

  @override
  String toString() {
    return 'User(userId: $userId, userName: $userName, email: $email, roleName: $roleName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.userId == userId &&
        other.userName == userName &&
        other.email == email;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ userName.hashCode ^ email.hashCode;
  }
}
