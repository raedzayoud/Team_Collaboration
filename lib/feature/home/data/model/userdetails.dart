class UserDetails {
  final int id;
  final String username;
  final String email;
  final bool active;

  UserDetails({
    required this.id,
    required this.username,
    required this.email,
    required this.active,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      active: json['active'],
    );
  }
}
