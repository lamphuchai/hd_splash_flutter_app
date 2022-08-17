// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'models.dart';

class Photo {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String? promotedAt;
  final int width;
  final int height;
  final String color;
  final String? blurHash;
  final int downloads;
  final String? description;
  final String? altDescription;
  final Urls urls;
  final Links links;
  final int views;
  final List<String> categories;
  final int likes;
  final bool likedByUser;
  final List<String> currentUserCollections;
  final Sponsorship? sponsorship;
  final Map? topicSubmissions;
  final User user;
  final Exif? exif;
  final List<Tag> tags;
  Photo(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.downloads,
      required this.views,
      this.promotedAt,
      required this.width,
      required this.height,
      required this.color,
      this.blurHash,
      this.description,
      this.altDescription,
      this.exif,
      required this.urls,
      required this.links,
      required this.categories,
      required this.likes,
      required this.likedByUser,
      required this.currentUserCollections,
      this.sponsorship,
      this.topicSubmissions,
      required this.user,
      required this.tags});

  Photo copyWith(
      {String? id,
      String? createdAt,
      String? updatedAt,
      String? promotedAt,
      int? width,
      int? height,
      String? color,
      String? blurHash,
      String? description,
      String? altDescription,
      Urls? urls,
      Links? links,
      List<String>? categories,
      int? likes,
      bool? likedByUser,
      List<String>? currentUserCollections,
      Sponsorship? sponsorship,
      Map? topicSubmissions,
      User? user,
      int? downloads,
      int? views,
      Exif? exif,
      List<Tag>? tags}) {
    return Photo(
        id: id ?? this.id,
        views: views ?? this.views,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        promotedAt: promotedAt ?? this.promotedAt,
        width: width ?? this.width,
        downloads: downloads ?? this.downloads,
        height: height ?? this.height,
        color: color ?? this.color,
        blurHash: blurHash ?? this.blurHash,
        description: description ?? this.description,
        altDescription: altDescription ?? this.altDescription,
        urls: urls ?? this.urls,
        links: links ?? this.links,
        categories: categories ?? this.categories,
        likes: likes ?? this.likes,
        likedByUser: likedByUser ?? this.likedByUser,
        currentUserCollections:
            currentUserCollections ?? this.currentUserCollections,
        sponsorship: sponsorship ?? this.sponsorship,
        topicSubmissions: topicSubmissions ?? this.topicSubmissions,
        user: user ?? this.user,
        tags: tags ?? this.tags,
        exif: exif ?? this.exif);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'promoted_at': promotedAt,
      'width': width,
      'height': height,
      'color': color,
      'blurHash': blurHash,
      'description': description,
      'altDescription': altDescription,
      'urls': urls.toMap(),
      'links': links.toMap(),
      'categories': categories,
      'likes': likes,
      'likedByUser': likedByUser,
      'currentUserCollections': currentUserCollections,
      'sponsorship': sponsorship,
      'topicSubmissions': topicSubmissions,
      'user': user.toMap(),
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
        id: map['id'],
        views: map["views"]?.toInt() ?? 0,
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        promotedAt:
            map['promoted_at'] != null ? map['promoted_at'] as String : null,
        width: map['width']?? 1,
        height: map['height'] ?? 1,
        color: map['color'],
        blurHash: map['blur_hash'],
        downloads: map['downloads']?.toInt() ?? 0,
        description:
            map['description'] != null ? map['description'] as String : null,
        altDescription: map['alt_description'] != null
            ? map['alt_description'] as String
            : null,
        urls: Urls.fromMap(map['urls']),
        links: Links.fromMap(map['links']),
        categories: List<String>.from(map['categories']),
        exif: map['exif'] != null ? Exif.fromMap(map['exif']) : null,
        likes: map['likes'] as int,
        likedByUser: map['liked_by_user'] as bool,
        currentUserCollections: map["current_user_collections"] != null
            ? (map["current_user_collections"] as List)
                .map((collection) => collection["id"].toString())
                .toList()
            : [],
        sponsorship: map['sponsorship'] != null
            ? Sponsorship.fromMap(map['sponsorship'])
            : null,
        topicSubmissions: map['topic_submissions'],
        user: User.fromMap(map['user'] as Map<String, dynamic>),
        tags: map["tags"] != null
            ? (map["tags"] as List).map((tag) => Tag.fromMap(tag)).toList()
            : []);
  }

  String toJson() => json.encode(toMap());

  factory Photo.fromJson(String source) =>
      Photo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Photo(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, promotedAt: $promotedAt, width: $width, height: $height, color: $color, blurHash: $blurHash, description: $description, altDescription: $altDescription, urls: $urls, links: $links, categories: $categories, likes: $likes, likedByUser: $likedByUser, currentUserCollections: $currentUserCollections, sponsorship: $sponsorship, topicSubmissions: $topicSubmissions, user: $user)';
  }

  @override
  bool operator ==(covariant Photo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.promotedAt == promotedAt &&
        other.width == width &&
        other.height == height &&
        other.color == color &&
        other.blurHash == blurHash &&
        other.downloads == downloads &&
        other.description == description &&
        other.altDescription == altDescription &&
        other.urls == urls &&
        other.links == links &&
        other.views == views &&
        listEquals(other.categories, categories) &&
        other.likes == likes &&
        other.likedByUser == likedByUser &&
        listEquals(other.currentUserCollections, currentUserCollections) &&
        other.sponsorship == sponsorship &&
        other.topicSubmissions == topicSubmissions &&
        other.user == user &&
        other.exif == exif &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        promotedAt.hashCode ^
        width.hashCode ^
        height.hashCode ^
        color.hashCode ^
        blurHash.hashCode ^
        downloads.hashCode ^
        description.hashCode ^
        altDescription.hashCode ^
        urls.hashCode ^
        links.hashCode ^
        views.hashCode ^
        categories.hashCode ^
        likes.hashCode ^
        likedByUser.hashCode ^
        currentUserCollections.hashCode ^
        sponsorship.hashCode ^
        topicSubmissions.hashCode ^
        user.hashCode ^
        exif.hashCode ^
        tags.hashCode;
  }
}
