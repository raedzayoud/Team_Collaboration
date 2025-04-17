import 'package:collab_doc/feature/home/data/model/userdetails.dart';

class Team {
  final int id;
  final String name;
  final String description;
  final int maxMembers;
  final UserDetails userOwner;
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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      maxMembers: json['maxMembers'],
      userOwner: UserDetails.fromJson(json['userOwner']),
      members: (json['members'] as List)
          .map((member) => UserDetails.fromJson(member))
          .toList(),
    );
  }
}