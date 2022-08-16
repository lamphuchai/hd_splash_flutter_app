// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tag {
  final String type;
  final String title;
  Tag({
    required this.type,
    required this.title,
  });

  Tag copyWith({
    String? type,
    String? title,
  }) {
    return Tag(
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'title': title,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      type: map['type'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) =>
      Tag.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Tag(type: $type, title: $title)';

  @override
  bool operator ==(covariant Tag other) {
    if (identical(this, other)) return true;

    return other.type == type && other.title == title;
  }

  @override
  int get hashCode => type.hashCode ^ title.hashCode;
}
