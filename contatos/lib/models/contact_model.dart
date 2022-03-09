import 'dart:convert';

class ContactTable {
  static String nameTable = "contact";
  static String fieldId = "id";
  static String fieldName = "name";
  static String fieldEmail = "email";
  static String fieldPhone = "phone";
  static String fieldImg = "img";

  static List<String> get columns {
    return [fieldId, fieldName, fieldEmail, fieldPhone, fieldImg];
  }
}

class ContactModel {
  int? id;
  String name;
  String? email;
  String? phone;
  String? img;

  ContactModel({
    this.id,
    required this.name,
    this.email,
    this.phone,
    this.img,
  });

  ContactModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? img,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'img': img,
    };
  }

  factory ContactModel.fromMap(Map<dynamic, dynamic> map) {
    return ContactModel(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, email: $email, phone: $phone, img: $img)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.img == img;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ phone.hashCode ^ img.hashCode;
  }
}
