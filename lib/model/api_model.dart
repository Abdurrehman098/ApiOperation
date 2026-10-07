class ApiModel {
  final int? userId;
  final int? id;
  final String title;
  final String body;

  ApiModel({
    this.userId,
    this.id,
    required this.title,
    required this.body,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'] ?? "",
      body: json['body'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "body": body,
    };
  }
}