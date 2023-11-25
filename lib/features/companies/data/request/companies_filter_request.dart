
class CompaniesFilterRequest{
  String? name;

  int? companyId;


  CompaniesFilterRequest({
    this.name,
    this.companyId,
  });

  CompaniesFilterRequest copyWith({
    String? name,
    int? companyId,

  }) {
    return CompaniesFilterRequest(
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'companyId': companyId,
    };
  }

  void clearFilter() {
    name= null;
    companyId= null;
  }

}