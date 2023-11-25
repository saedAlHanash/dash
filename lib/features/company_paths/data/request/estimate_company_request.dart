class EstimateCompanyRequest {
  EstimateCompanyRequest({
    this.pathEdgesIds,
  });

  List<num>? pathEdgesIds;

  factory EstimateCompanyRequest.fromJson(Map<String, dynamic> json) {
    return EstimateCompanyRequest(
      pathEdgesIds: json["pathEdgesIds"] == null
          ? []
          : List<num>.from(json["pathEdgesIds"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "pathEdgesIds": pathEdgesIds?.map((x) => x).toList(),
      };
}
