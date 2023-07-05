class NoteRequest {
  NoteRequest({
    this.userId,
    this.title,
    this.body,
  });

  int? userId;
  String? title;
  String? body;

  factory NoteRequest.fromJson(Map<String, dynamic> json) {
    return NoteRequest(
      userId: json['userId'] ?? 0,
      title: json['tilte'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'tilte': title,
        'body': body,
      };
}
