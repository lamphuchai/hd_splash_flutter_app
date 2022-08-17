// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


import 'models.dart';

class User {
  final String id;
  final String updatedAt;
  final String username;
  final String name;
  final ProfileImage profileImage;
  final Links links;
  final int totalCollections;
  final int totalLikes;
  final int totalPhotos;
  final bool acceptedTos;
  final Social? social;
  final String? firstName;
  final String? lastName;
  final String? twitterUsername;
  final String? portfolioUrl;
  final String? bio;
  final String? email;

  final String? location;
  final String? instagramUsername;
  final bool? forHire;
  final bool? followedByUser;
  final Map<String, dynamic>? tags;
  final int? followersCount;
  final int? followingCount;
  final bool? allowMessages;
  final int? numericId;
  final int? downloads;
  final Meta? meta;
  const User(
      {required this.id,
      required this.updatedAt,
      required this.username,
      required this.name,
      this.firstName,
      this.lastName,
      this.twitterUsername,
      this.portfolioUrl,
      this.bio,
      this.email,
      this.location,
      required this.links,
      required this.profileImage,
      this.instagramUsername,
      required this.totalCollections,
      required this.totalLikes,
      required this.totalPhotos,
      required this.acceptedTos,
      this.forHire,
      this.social,
      this.followedByUser,
      this.tags,
      this.followersCount,
      this.followingCount,
      this.allowMessages,
      this.numericId,
      this.downloads,
      this.meta});

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
      'social': social?.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      updatedAt: json['updated_at'],
      username: json['username'],
      name: json['name'],
      profileImage: ProfileImage.fromMap(json['profile_image']),
      links: Links.fromMap(json['links']),
      totalCollections: json['total_collections'],
      totalLikes: json['total_likes'],
      totalPhotos: json['total_photos'],
      acceptedTos: json['accepted_tos'],
      social: json['social'] != null ? Social.fromMap(json['social']) : null,
      firstName: json['first_name'],
      lastName: json['last_name'],
      twitterUsername: json['twitter_username'],
      portfolioUrl: json['portfolio_url'],
      bio: json['bio'],
      email: json['email'],
      location: json['location'],
      instagramUsername: json['instagram_username'],
      forHire: json['for_hire'],
      followedByUser: json['followed_by_user'],
      tags: json['tags'],
      followersCount: json['followers_count'],
      followingCount: json['following_count'],
      allowMessages: json['allow_messages'],
      numericId: json['numeric_id'],
      downloads: json['downloads'],
      meta: json['meta'] != null ? Meta.fromMap(json['meta']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, updatedAt: $updatedAt, username: $username, name: $name, firstName: $firstName, lastName: $lastName, twitterUsername: $twitterUsername, portfolioUrl: $portfolioUrl, bio: $bio, location: $location, links: $links, profileImage: $profileImage, instagramUsername: $instagramUsername, totalCollections: $totalCollections, totalLikes: $totalLikes, totalPhotos: $totalPhotos, acceptedTos: $acceptedTos, forHire: $forHire, social: $social)';
  }
}
