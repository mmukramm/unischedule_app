class User {
  final String fullName;
  final String nim;
  final String gender;
  final String phone;
  final String email;
  final String? image;

  User({
    required this.fullName,
    required this.nim,
    required this.gender,
    required this.phone,
    required this.email,
    this.image,

  });
}