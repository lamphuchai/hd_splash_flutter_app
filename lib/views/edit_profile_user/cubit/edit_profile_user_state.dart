// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_profile_user_cubit.dart';

enum Status { init, complete, err }

class EditProfileUserState extends Equatable {
  const EditProfileUserState(
      {this.status = Status.init,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.portfolioUrl,
      required this.instagramUsername,
      required this.location,
      required this.bio});

  final Status status;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String portfolioUrl;
  final String instagramUsername;
  final String location;
  final String bio;

  @override
  List<Object> get props => [
        status,
        username,
        firstName,
        lastName,
        email,
        portfolioUrl,
        instagramUsername,
        location,
        bio
      ];

  static EditProfileUserState fromUser(User user, {Status? status}) =>
      EditProfileUserState(
          status: status ?? Status.init,
          username: user.username,
          firstName: user.firstName ?? "",
          lastName: user.lastName ?? "",
          email: user.email ?? "",
          portfolioUrl: user.portfolioUrl ?? "",
          instagramUsername: user.instagramUsername ?? "",
          location: user.location ?? "",
          bio: user.bio ?? "");

  EditProfileUserState copyWith({
    Status? status,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? portfolioUrl,
    String? instagramUsername,
    String? location,
    String? bio,
  }) {
    return EditProfileUserState(
      status: status ?? this.status,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      instagramUsername: instagramUsername ?? this.instagramUsername,
      location: location ?? this.location,
      bio: bio ?? this.bio,
    );
  }
}
