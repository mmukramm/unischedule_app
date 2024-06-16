// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String? id;
  final String? name;
  final String? stdCode;
  final String? gender;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? profileImage;

  User(
      {this.id,
      this.name,
      this.stdCode,
      this.gender,
      this.email,
      this.phoneNumber,
      this.role,
      this.profileImage});

  User copyWith({
    String? id,
    String? name,
    String? stdCode,
    String? gender,
    String? email,
    String? phoneNumber,
    String? role,
    String? profileImage,
  }) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        stdCode: stdCode ?? this.stdCode,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        role: role ?? this.role,
        profileImage: profileImage ?? this.profileImage);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'std_code': stdCode,
      'gender': gender,
      'email': email,
      'phone_number': phoneNumber,
      'role': role,
      'profile_image': profileImage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      stdCode: map['std_code'] != null ? map['std_code'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      profileImage:
          map['profile_image'] != null ? map['profile_image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, stdCode: $stdCode, gender: $gender, email: $email, phoneNumber: $phoneNumber, role: $role, profileImage: $profileImage)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.stdCode == stdCode &&
        other.gender == gender &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.role == role &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        stdCode.hashCode ^
        gender.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        role.hashCode ^
        profileImage.hashCode;
  }
}
