class RatingResponse {
  RatingResponse({
    required this.userId,
    required this.ratedUserId,
    required this.rating,
    required this.notes,
    required this.userName,
    required this.ratedUserName,
  });

  final int userId;
  final int ratedUserId;
  final double rating;
  final String notes;
  final String userName;
  final String ratedUserName;

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      userId: json['userId'] ?? 0,
      ratedUserId: json['ratedUserId'] ?? 0,
      rating: json['rateing'] ?? 0,
      notes: json['notes'] ?? '',
      userName: json['userName'] ?? '',
      ratedUserName: json['ratedUserName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'ratedUserId': ratedUserId,
        'rateing': rating,
        'notes': notes,
        'userName': userName,
        'ratedUserName': ratedUserName,
      };
}
