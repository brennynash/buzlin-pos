class CustomerData {
  String? firstname;
  String? lastname;
  String? email;
  int? phone;
  String? password;
  String? role;
  String? imageUrl;
  String? title;
  String? description;

  CustomerData(
      {
        this.firstname,
        this.lastname,
        this.email,
        this.phone,
        this.role,
        this.password,
        this.imageUrl,
        this.title,
        this.description
      });

  CustomerData copyWith({
    String? firstname,
    String? lastname,
    String? email,
    int? phone,
    String? role,
    String? password,
    String? imageUrl,
    String? title,
    String? description
  }) =>
      CustomerData(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        password: password ?? this.password,
        imageUrl: imageUrl ?? this.imageUrl,
        title: title ?? this.title,
        description: description ?? this.description
      );

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    role: json["role"],
    password: json["password"],
    imageUrl: json["imageUrl"],
    title: json["title"],
    description: json["description"]
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      "firstname": firstname,
      "email": email,
      "phone": phone,
      "role": role,
    };

    if (password != null) {
      jsonMap["password"] = password;
    }
    if (imageUrl != null) {
      jsonMap["imageUrl"] = imageUrl;
    }
    if (lastname != null) {
      jsonMap["lastname"] = lastname;
    }
    if (title != null) {
      jsonMap["title"] = title;
    }
    if (description != null) {
      jsonMap["description"] = description;
    }

    return jsonMap;
  }

}
