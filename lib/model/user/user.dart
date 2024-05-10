import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  createToJson: true,
  explicitToJson: true,
)
class UserAccount {

  String uid;
  // String? username;
  String? email;
  // String? phoneNumber;
  String? gender;
  String? firstName;
  String? lastName;
  String? profileURL;
  bool? verified;
  String? bio;

  UserAccount({required this.uid,
    // this.username,
    this.email,
    // this.phoneNumber,
    this.gender,
    this.firstName,
    this.lastName,
    this.profileURL,
    this.verified,
    this.bio,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);

  UserAccount copy() => UserAccount.fromJson(toJson());
}
