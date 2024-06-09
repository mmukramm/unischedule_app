// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserInfo {
  final String? id;
  final String? name;
  final String? stdCode;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? role;
  final bool? isVerified;

  UserInfo({
    this.id,
    this.name,
    this.stdCode,
    this.email,
    this.phoneNumber,
    this.gender,
    this.role,
    this.isVerified,
  });

  UserInfo copyWith({
    String? id,
    String? name,
    String? stdCode,
    String? email,
    String? phoneNumber,
    String? gender,
    String? role,
    bool? isVerified,
  }) {
    return UserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      stdCode: stdCode ?? this.stdCode,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'std_code': stdCode,
      'email': email,
      'phone_number': phoneNumber,
      'gender': gender,
      'role': role,
      'is_verified': isVerified,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      stdCode: map['std_code'] != null ? map['std_code'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phone_number'] != null ? map['phone_number'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      isVerified: map['is_verified'] != null ? map['is_verified'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfo(id: $id, name: $name, stdCode: $stdCode, email: $email, phoneNumber: $phoneNumber, gender: $gender, role: $role, isVerified: $isVerified)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.stdCode == stdCode &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.gender == gender &&
      other.role == role &&
      other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      stdCode.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      gender.hashCode ^
      role.hashCode ^
      isVerified.hashCode;
  }
}
