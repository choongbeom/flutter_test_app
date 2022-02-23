// ignore_for_file: file_names

class RestApiSample {
  int? userId;
  int? id;
  String? title;
  String? body;

  RestApiSample({this.userId, this.id, this.title, this.body});

  factory  RestApiSample.fromJson(Map<String, dynamic> json) {
    return RestApiSample(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}