import 'dart:convert';

Debt debtFromJson(String str) {
  final jsonData = json.decode(str);
  return Debt.fromMap(jsonData);
}

String debtToJson(Debt data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Debt {
  final int id;
  int value;
  final String title;
  final String detail;
  final String target;
  final String dateCreated;

  Debt({
    this.id,
    this.value,
    this.title,
    this.detail,
    this.target,
    this.dateCreated,
  });

  factory Debt.fromMap(Map<String, dynamic> json) => new Debt(
        id: json["id"],
        value: json["value"],
        title: json["title"],
        detail: json["detail"],
        target: json["target"],
        dateCreated: json["date_created"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "value": value,
        "title": title,
        "detail": detail,
        "target": target,
        "date_created": dateCreated,
      };
}
