// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'models.dart';


class PreviewPhotos {
  final String id;
  final String createdAt;
  final String updatedAt;
  final Urls urls;
  PreviewPhotos({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.urls,
  });

  PreviewPhotos copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    Urls? urls,
  }) {
    return PreviewPhotos(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      urls: urls ?? this.urls,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'urls': urls.toMap(),
    };
  }

  factory PreviewPhotos.fromMap(Map<String, dynamic> map) {
    return PreviewPhotos(
      id: map['id'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      urls: Urls.fromMap(map['urls'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PreviewPhotos.fromJson(String source) =>
      PreviewPhotos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PreviewPhotos(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, urls: $urls)';
  }

}
