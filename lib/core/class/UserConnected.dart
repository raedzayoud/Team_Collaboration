import 'dart:ffi';

class UserConnected {
  final Long id;
  final String username;
  final String email;
  final bool isActive;

  UserConnected(
      {required this.email,
      required this.id,
      required this.isActive,
      required this.username});

  // Convert User object to JSON
  Map<String, dynamic> toJson() =>
      {'id': id, 'username': username, 'email': email, 'isActive': isActive};

  // Create User object from JSON
  factory UserConnected.fromJson(Map<String, dynamic> json) => UserConnected(
        id: json['id'],
        username: json['name'],
        isActive: json['isActive'],
        email: json['email'],
      );
}
