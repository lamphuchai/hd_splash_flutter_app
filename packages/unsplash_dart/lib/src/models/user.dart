// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'models.dart';


class User {
  final String id;
  final String updatedAt;
  final String username;
  final String name;
  final String? firstName;
  final String? lastName;
  final String? twitterUsername;
  final String? portfolioUrl;
  final String? bio;
  final String? location;
  final Links links;
  final ProfileImage profileImage;
  final String? instagramUsername;
  final int totalCollections;
  final int totalLikes;
  final int totalPhotos;
  final bool acceptedTos;
  final bool forHire;
  final Social social;
  User({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    required this.links,
    required this.profileImage,
    this.instagramUsername,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
    required this.acceptedTos,
    required this.forHire,
    required this.social,
  });

  User copyWith({
    String? id,
    String? updatedAt,
    String? username,
    String? name,
    String? firstName,
    String? lastName,
    String? twitterUsername,
    String? portfolioUrl,
    String? bio,
    String? location,
    Links? links,
    ProfileImage? profileImage,
    String? instagramUsername,
    int? totalCollections,
    int? totalLikes,
    int? totalPhotos,
    bool? acceptedTos,
    bool? forHire,
    Social? social,
  }) {
    return User(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      twitterUsername: twitterUsername ?? this.twitterUsername,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      links: links ?? this.links,
      profileImage: profileImage ?? this.profileImage,
      instagramUsername: instagramUsername ?? this.instagramUsername,
      totalCollections: totalCollections ?? this.totalCollections,
      totalLikes: totalLikes ?? this.totalLikes,
      totalPhotos: totalPhotos ?? this.totalPhotos,
      acceptedTos: acceptedTos ?? this.acceptedTos,
      forHire: forHire ?? this.forHire,
      social: social ?? this.social,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'updated_at': updatedAt,
      'username': username,
      'name': name,
      'first_name': firstName,
      'last_name': lastName,
      'twitter_username': twitterUsername,
      'portfolio_url': portfolioUrl,
      'bio': bio,
      'location': location,
      'links': links.toMap(),
      'profile_image': profileImage.toMap(),
      'instagram_username': instagramUsername,
      'total_collections': totalCollections,
      'total_likes': totalLikes,
      'total_photos': totalPhotos,
      'accepted_tos': acceptedTos,
      'for_hire': forHire,
      'social': social.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      updatedAt: map['updated_at'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      twitterUsername: map['twitter_username'] != null
          ? map['twitter_username'] as String
          : null,
      portfolioUrl:
          map['portfolio_url'] != null ? map['portfolio_url'] as String : null,
      bio: map['bio'],
      location: map['location'],
      links: Links.fromMap(map['links'] as Map<String, dynamic>),
      profileImage:
          ProfileImage.fromMap(map['profile_image'] as Map<String, dynamic>),
      instagramUsername: map['instagram_username'] != null
          ? map['instagram_username'] as String
          : null,
      totalCollections: map['total_collections'] as int,
      totalLikes: map['total_likes'] as int,
      totalPhotos: map['total_photos'] as int,
      acceptedTos: map['accepted_tos'] as bool,
      forHire: map['for_hire'] as bool,
      social: Social.fromMap(map['social'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, updatedAt: $updatedAt, username: $username, name: $name, firstName: $firstName, lastName: $lastName, twitterUsername: $twitterUsername, portfolioUrl: $portfolioUrl, bio: $bio, location: $location, links: $links, profileImage: $profileImage, instagramUsername: $instagramUsername, totalCollections: $totalCollections, totalLikes: $totalLikes, totalPhotos: $totalPhotos, acceptedTos: $acceptedTos, forHire: $forHire, social: $social)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.updatedAt == updatedAt &&
        other.username == username &&
        other.name == name &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.twitterUsername == twitterUsername &&
        other.portfolioUrl == portfolioUrl &&
        other.bio == bio &&
        other.location == location &&
        other.links == links &&
        other.profileImage == profileImage &&
        other.instagramUsername == instagramUsername &&
        other.totalCollections == totalCollections &&
        other.totalLikes == totalLikes &&
        other.totalPhotos == totalPhotos &&
        other.acceptedTos == acceptedTos &&
        other.forHire == forHire &&
        other.social == social;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        updatedAt.hashCode ^
        username.hashCode ^
        name.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        twitterUsername.hashCode ^
        portfolioUrl.hashCode ^
        bio.hashCode ^
        location.hashCode ^
        links.hashCode ^
        profileImage.hashCode ^
        instagramUsername.hashCode ^
        totalCollections.hashCode ^
        totalLikes.hashCode ^
        totalPhotos.hashCode ^
        acceptedTos.hashCode ^
        forHire.hashCode ^
        social.hashCode;
  }
}
