// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'models.dart';



class Collection {
  final String id;
  final String title;
  final String? description;
  final String publishedAt;
  final String lastCollectedAt;
  final String updatedAt;
  final bool curated;
  final bool featured;
  final int totalPhotos;
  final bool private;
  final String shareKey;
  final List<Tag> tags;
  final Links links;
  final User user;
  final Photo? coverPhoto;
  final List<PreviewPhotos> previewPhotos;
  final Mate? mate;
  Collection({
    required this.id,
    required this.title,
    this.description,
    required this.publishedAt,
    required this.lastCollectedAt,
    required this.updatedAt,
    required this.curated,
    required this.featured,
    required this.totalPhotos,
    required this.private,
    required this.shareKey,
    required this.tags,
    required this.links,
    required this.user,
    this.coverPhoto,
    required this.previewPhotos,
    this.mate,
  });

  Collection copyWith({
    String? id,
    String? title,
    String? description,
    String? publishedAt,
    String? lastCollectedAt,
    String? updatedAt,
    bool? curated,
    bool? featured,
    int? totalPhotos,
    bool? private,
    String? shareKey,
    List<Tag>? tags,
    Links? links,
    User? user,
    Photo? coverPhoto,
    List<PreviewPhotos>? previewPhotos,
    Mate? mate,
  }) {
    return Collection(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      publishedAt: publishedAt ?? this.publishedAt,
      lastCollectedAt: lastCollectedAt ?? this.lastCollectedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      curated: curated ?? this.curated,
      featured: featured ?? this.featured,
      totalPhotos: totalPhotos ?? this.totalPhotos,
      private: private ?? this.private,
      shareKey: shareKey ?? this.shareKey,
      tags: tags ?? this.tags,
      links: links ?? this.links,
      user: user ?? this.user,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      previewPhotos: previewPhotos ?? this.previewPhotos,
      mate: mate ?? this.mate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'published_at': publishedAt,
      'lastCollected_at': lastCollectedAt,
      'updated_at': updatedAt,
      'curated': curated,
      'featured': featured,
      'total_photos': totalPhotos,
      'private': private,
      'share_key': shareKey,
      'tags': tags.map((x) => x.toMap()).toList(),
      'links': links.toMap(),
      'user': user.toMap(),
      'cover_photo': coverPhoto?.toMap(),
      'preview_photos': previewPhotos.map((x) => x.toMap()).toList(),
      'mate': mate?.toMap(),
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      publishedAt: map['published_at'],
      lastCollectedAt: map['last_collected_at'],
      updatedAt: map['updated_at'],
      curated: map['curated'] as bool,
      featured: map['featured'] as bool,
      totalPhotos: map['total_photos'] as int,
      private: map['private'] as bool,
      shareKey: map['share_key'] as String,
      tags: List<Tag>.from(
        (map['tags'] as List).map<Tag>(
          (x) => Tag.fromMap(x as Map<String, dynamic>),
        ),
      ),
      links: Links.fromMap(map['links'] as Map<String, dynamic>),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      coverPhoto: map['cover_photo'] != null
          ? Photo.fromMap(map['cover_photo'] as Map<String, dynamic>)
          : null,
      previewPhotos: map['preview_photos'] != null
          ? List<PreviewPhotos>.from(
              (map['preview_photos'] as List).map<PreviewPhotos>(
              (x) => PreviewPhotos.fromMap(x as Map<String, dynamic>),
            ))
          : [],
      mate: map['mate'] != null
          ? Mate.fromMap(map['mate'] as Map<String, dynamic>)
          : null,
    );
  }

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Collection(id: $id, title: $title, description: $description, publishedAt: $publishedAt, lastCollectedAt: $lastCollectedAt, updatedAt: $updatedAt, curated: $curated, featured: $featured, totalPhotos: $totalPhotos, private: $private, shareKey: $shareKey, tags: $tags, links: $links, user: $user, coverPhoto: $coverPhoto, previewPhotos: $previewPhotos, mate: $mate)';
  }
}
