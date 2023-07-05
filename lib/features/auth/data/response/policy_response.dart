class PolicyResponse {
  PolicyResponse({
    required this.result,
  });

  final PolicyResult result;

  factory PolicyResponse.fromJson(Map<String, dynamic> json) {
    return PolicyResponse(
      result: json["result"] == null
          ? PolicyResult.fromJson({})
          : PolicyResult.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {"result": result.toJson()};
}

class PolicyResult {
  PolicyResult({required this.policy});

  final String policy;

  factory PolicyResult.fromJson(Map<String, dynamic> json) {
    return PolicyResult(policy: json["policy"] ?? "");
  }

  Map<String, dynamic> toJson() => {"policy": policy};
}
