class Company {
  String name;
  String catchPhrase;
  String bs;
  Company({this.bs, this.catchPhrase, this.name});

  factory Company.fromJson(json) {
    if (json != null) {
      return Company(
          name: json['name'] ?? '',
          catchPhrase: json['catchPhrase'] ?? '',
          bs: json['bs'] ?? '');
    }
    return Company();
  }
}
