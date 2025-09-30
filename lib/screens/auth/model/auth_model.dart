class AuthModel {
    String accessToken;
    String refreshToken;
    String tokenType;
    int expiresIn;
    User user;
    bool requiresConsent;
    bool requiresProfile;

    AuthModel({
        required this.accessToken,
        required this.refreshToken,
        required this.tokenType,
        required this.expiresIn,
        required this.user,
        required this.requiresConsent,
        required this.requiresProfile,
    });

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken: json['accessToken']??'',
        refreshToken: json['refreshToken']??'',
        tokenType: json['tokenType']??'',
        expiresIn: json['expiresIn'],
        user: User.fromJson(json['user']),
        requiresConsent: json['requiresConsent']??false,
        requiresProfile: json['requiresProfile']??false,
    );

    Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'tokenType': tokenType,
        'expiresIn': expiresIn,
        'user': user.toJson(),
        'requiresConsent': requiresConsent,
        'requiresProfile': requiresProfile,
    };
}

class User {
    String userId;
    String mobileNo;
    String firstName;
    String lastName;
    String email;
    DateTime? createdAt;

    User({
        required this.userId,
        required this.mobileNo,
        required this.firstName,
        required this.lastName,
        required this.email,
        this.createdAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId']??'',
        mobileNo: json['mobileNo']??'',
        firstName: json['firstName']??'',
        lastName: json['lastName']??'',
        email: json['email']??'',
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );

    Map<String, dynamic> toJson() => {
        'userId': userId,
        'mobileNo': mobileNo,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'createdAt': createdAt?.toIso8601String(),
    };
}
