class UserModel {
  final int? id;
  final String username;
  final String password;
  final String? accessToken;

  UserModel({
    this.id,
    required this.username,
    required this.password,
    this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}