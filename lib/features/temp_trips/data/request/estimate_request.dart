class EstimateRequest {
  EstimateRequest({
    this.pathEdgesIds,
  });

  List<num>? pathEdgesIds;

  factory EstimateRequest.fromJson(Map<String, dynamic> json) {
    return EstimateRequest(
      pathEdgesIds: json["pathEdgesIds"] == null
          ? []
          : List<num>.from(json["pathEdgesIds"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "pathEdgesIds": pathEdgesIds?.map((x) => x).toList(),
      };
}
