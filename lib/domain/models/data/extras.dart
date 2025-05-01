import 'group.dart';

class Extras {
  int? id;
  int? stockId;
  int? extraValueId;
  int? extraGroupId;
  String? value;
  Group? group;

  Extras({
    this.id,
    this.stockId,
    this.extraValueId,
    this.extraGroupId,
    this.value,
    this.group,
  });

  Extras copyWith({
    int? id,
    int? stockId,
    int? extraValueId,
    int? extraGroupId,
    String? value,
    Group? group,
  }) =>
      Extras(
        id: id ?? this.id,
        stockId: stockId ?? this.stockId,
        extraValueId: extraValueId ?? this.extraValueId,
        extraGroupId: extraGroupId ?? this.extraGroupId,
        value: value ?? this.value,
        group: group ?? this.group,
      );

  factory Extras.fromJson(Map<String, dynamic> json) {
    int? id;
    String? value;

    try {
      id = json['value']['id'] != null ? (json['value']?['id'] ?? "") : null;
    } catch (e) {
      id = json['id'] != null ? (json['id'] ?? "") : null;
    }
    try {
      value = json['value'] != null ? (json['value']?['value'] ?? "") : null;
    } catch (e) {
      value = json['value'] != null ? (json['value'] ?? "") : null;
    }
    return Extras(
      id: id,
      stockId: json["stock_id"],
      extraValueId: json["extra_value_id"],
      extraGroupId: json["extra_group_id"],
      value: value,
      group: json["group"] == null ? null : Group.fromJson(json["group"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "stock_id": stockId,
    "extra_value_id": extraValueId,
    "extra_group_id": extraGroupId,
    "value": value,
    "group": group?.toJson(),
  };
}
