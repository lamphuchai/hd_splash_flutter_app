// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Statistic {
  const Statistic(
      {required this.id,
      required this.downloads,
      required this.views,
      required this.likes});
  final String id;
  final Map<String, dynamic>? downloads;
  final Map<String, dynamic>? views;
  final Map<String, dynamic>? likes;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'downloads': downloads,
      'views': views,
      'likes': likes,
    };
  }

  factory Statistic.fromMap(Map<String, dynamic> map) {
    return Statistic(
        id: map["id"],
        downloads: map["downloads"],
        views: map["views"],
        likes: map["likes"]);
  }

  String toJson() => json.encode(toMap());

  factory Statistic.fromJson(String source) =>
      Statistic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Statistic(id: $id, downloads: $downloads, views: $views, likes: $likes)';
  }
}
