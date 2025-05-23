class Translation {
  Translation({
    int? id,
    String? locale,
    String? title,
    String? description,
    String? shortDesc,
    String? address,
    String? term,
  }) {
    _id = id;
    _locale = locale;
    _title = title;
    _description = description;
    _shortDesc = shortDesc;
    _address = address;
    _term = term;
  }

  Translation.fromJson(dynamic json) {
    _id = json['id'];
    _locale = json['locale'];
    _title = json['title'];
    _description = json['description'];
    _shortDesc = json['short_desc'];
    _address = json['address'];
    _term = json['term'];
  }

  int? _id;
  String? _locale;
  String? _title;
  String? _description;
  String? _shortDesc;
  String? _address;
  String? _term;

  Translation copyWith({
    int? id,
    String? locale,
    String? title,
    String? description,
    String? shortDesc,
    String? address,
    String? term,
  }) =>
      Translation(
        id: id ?? _id,
        locale: locale ?? _locale,
        title: title ?? _title,
        description: description ?? _description,
        shortDesc: shortDesc ?? _shortDesc,
        address: address ?? _address,
        term: term ?? _term,
      );

  int? get id => _id;

  String? get locale => _locale;

  String? get title => _title;

  String? get description => _description;

  String? get shortDesc => _shortDesc;

  String? get address => _address;

  String? get term => _term;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['locale'] = _locale;
    map['title'] = _title;
    map['description'] = _description;
    map['short_desc'] = _shortDesc;
    map['address'] = _address;
    map['term'] = _term;
    return map;
  }
}
