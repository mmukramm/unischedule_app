// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Participant {
  final String? userId;
  final String? name;
  final String? stdCode;
  final String? phoneNumber;
  Participant({
    this.userId,
    this.name,
    this.stdCode,
    this.phoneNumber,
  });

  Participant copyWith({
    String? userId,
    String? name,
    String? stdCode,
    String? phoneNumber,
  }) {
    return Participant(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      stdCode: stdCode ?? this.stdCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'name': name,
      'std_code': stdCode,
      'phone_number': phoneNumber,
    };
  }

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      userId: map['user_id'] != null ? map['user_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      stdCode: map['std_code'] != null ? map['std_code'] as String : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Participant.fromJson(String source) =>
      Participant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Participant(userId: $userId, name: $name, stdCode: $stdCode, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant Participant other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.name == name &&
        other.stdCode == stdCode &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        stdCode.hashCode ^
        phoneNumber.hashCode;
  }
}
