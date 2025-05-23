import 'extras.dart';
import 'translation.dart';

class Group {
  Group({
    int? id,
    String? type,
    bool? isChecked,
    Translation? translation,
    List<Extras>? fetchedExtras,
    List<Extras>? extraValues,
  }) {
    _id = id;
    _type = type;
    _isChecked = isChecked;
    _translation = translation;
    _fetchedExtras = fetchedExtras;
    _extraValues = extraValues;
  }

  Group.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _isChecked = false;
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    _fetchedExtras = [];
    if (json['extra_values'] != null) {
      _extraValues = [];
      json['extra_values'].forEach((v) {
        _extraValues?.add(Extras.fromJson(v));
      });
    }
  }

  int? _id;
  String? _type;
  bool? _isChecked;
  Translation? _translation;
  List<Extras>? _fetchedExtras;
  List<Extras>? _extraValues;

  Group copyWith({
    int? id,
    String? type,
    bool? isChecked,
    Translation? translation,
    List<Extras>? fetchedExtras,
    List<Extras>? extraValues,
  }) =>
      Group(
        id: id ?? _id,
        type: type ?? _type,
        isChecked: isChecked ?? _isChecked,
        translation: translation ?? _translation,
        fetchedExtras: fetchedExtras ?? _fetchedExtras,
        extraValues: extraValues ?? _extraValues,
      );

  int? get id => _id;

  String? get type => _type;

  bool? get isChecked => _isChecked;

  Translation? get translation => _translation;

  List<Extras>? get fetchedExtras => _fetchedExtras;

  List<Extras>? get extraValues => _extraValues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    if (_extraValues != null) {
      map['extra_values'] = _extraValues?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
