class RatingRequest {
  RatingRequest({
    required this.orderId,
    required this.ratedUserId,
     this.rating = 1.0,
    required this.notes,
  });

  int orderId;
  int ratedUserId;
  double rating;
  String notes;

  factory RatingRequest.fromJson(Map<String, dynamic> json) {
    return RatingRequest(
      orderId: json["orderID"] ?? 0,
      ratedUserId: json["ratedUserId"] ?? 0,
      rating: json["rateing"] ?? 0.0,
      notes: json["notes"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "orderID": orderId,
        "ratedUserId": ratedUserId,
        "rateing": rating,
        "notes": notes,
      };
}
