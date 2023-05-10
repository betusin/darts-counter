import 'package:json_annotation/json_annotation.dart';
import 'package:dartboard/model/status_enum.dart';

part 'invite.g.dart';

@JsonSerializable()
class Invite extends Object with _$InviteSerializerMixin {
  final DateTime validUntil;
  final String inviteFrom;
  final String inviteFromUID;
  final String inviteToUID;
  final String inviteTo;
  final InviteStatus status;

  Invite({
    required this.validUntil,
    required this.inviteFrom,
    required this.inviteFromUID,
    required this.inviteToUID,
    required this.inviteTo,
    this.status = InviteStatus.pending,
  });

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

  Map<String, dynamic> toJson() => _$InviteToJson(this);
}
