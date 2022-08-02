// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'models.dart';

class Topic {
  final String id;
  final String slug;
  final String title;
  final String? description;
  final String publishedAt;
  final String updatedAt;
  final String startsAt;
  final String? endsAt;
  final String? onlySubmissionsAfter;
  final String visibility;
  final bool featured;
  final int totalPhotos;
  final Links links;
  final String status;
  final List<User> owners;
  final List<dynamic> currentUserContributions;
  final Map? totalCurrentUserSubmissions;
  final Photo? coverPhoto;
  final List<PreviewPhotos>? previewPhotos;
  Topic({
    required this.id,
    required this.slug,
    required this.title,
    this.description,
    required this.publishedAt,
    required this.updatedAt,
    required this.startsAt,
    this.endsAt,
    this.onlySubmissionsAfter,
    required this.visibility,
    required this.featured,
    required this.totalPhotos,
    required this.links,
    required this.status,
    required this.owners,
    required this.currentUserContributions,
    this.totalCurrentUserSubmissions,
    this.coverPhoto,
    this.previewPhotos,
  });

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
        id: map['id'],
        slug: map['slug'],
        title: map['title'],
        description: map['description'],
        publishedAt: map['published_at'],
        updatedAt: map['updated_at'],
        startsAt: map['starts_at'],
        endsAt: map['ends_at'],
        onlySubmissionsAfter: map['only_submissions_after'],
        visibility: map['visibility'],
        featured: map['featured'],
        totalPhotos: map['total_photos'],
        links: Links.fromMap(map['links'] as Map<String, dynamic>),
        status: map['status'],
        owners: List<User>.from(
          (map['owners'] as List).map<User>(
            (x) => User.fromMap(x as Map<String, dynamic>),
          ),
        ),
        currentUserContributions: map['current_user_contributions'] ?? [],
        totalCurrentUserSubmissions: map['total_current_user_submissions'],
        coverPhoto: map['cover_photo'] != null
            ? Photo.fromMap(map['cover_photo'] as Map<String, dynamic>)
            : null,
        previewPhotos: map['preview_photos'] != null
            ? (map['preview_photos'] as List)
                .map((e) => PreviewPhotos.fromMap(e))
                .toList()
            : null);
  }

  factory Topic.fromJson(String source) =>
      Topic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Topic(id: $id, slug: $slug, title: $title, description: $description, publishedAt: $publishedAt, updatedAt: $updatedAt, startsAt: $startsAt, endsAt: $endsAt, onlySubmissionsAfter: $onlySubmissionsAfter, visibility: $visibility, featured: $featured, totalPhotos: $totalPhotos, links: $links, status: $status, owners: $owners, currentUserContributions: $currentUserContributions, totalCurrentUserSubmissions: $totalCurrentUserSubmissions, coverPhoto: $coverPhoto, previewPhotos: $previewPhotos)';
  }
}
