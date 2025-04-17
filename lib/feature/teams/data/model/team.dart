import 'package:collab_doc/feature/home/data/model/userdetails.dart';

class Team {
  final int id;
  final String name;
  final String description;
  final int maxMembers;
  final UserDetails? userOwner;
  final List<UserDetails> members;

  Team({
    required this.id,
    required this.name,
    required this.description,
    required this.maxMembers,
    required this.userOwner,
    required this.members,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      maxMembers: json['maxMembers'] ?? 0,
      userOwner: json['userOwner'] != null
          ? UserDetails.fromJson(json['userOwner'])
          : null,
      members: (json['members'] as List?)
              ?.map((member) => UserDetails.fromJson(member))
              .toList() ??
          [],
    );
  }
}
