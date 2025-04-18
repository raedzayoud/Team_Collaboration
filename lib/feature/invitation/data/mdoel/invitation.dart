class InvitationModel {
  final int id;
  final int userSenderId;
  final String emailReceiver;
  final int teamId;
  final String status;

  InvitationModel({
    required this.id,
    required this.userSenderId,
    required this.emailReceiver,
    required this.teamId,
    required this.status,
  });

  // From JSON
  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'],
      userSenderId: json['userSenderId'],
      emailReceiver: json['emailReceiver'],
      teamId: json['teamId'],
      status: json['status'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userSenderId': userSenderId,
      'emailReceiver': emailReceiver,
      'teamId': teamId,
      'status': status,
    };
  }
}
