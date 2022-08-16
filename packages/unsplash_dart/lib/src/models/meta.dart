// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Meta {
  final String? title;
  final String? description;
  final bool index;
  Meta({
    required this.title,
    required this.description,
    required this.index,
  });

  Meta copyWith({
    String? title,
    String? description,
    bool? index,
  }) {
    return Meta(
      title: title ?? this.title,
      description: description ?? this.description,
      index: index ?? this.index,
    );
  }

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      index: map['index'] as bool,
    );
  }

  factory Meta.fromJson(String source) =>
      Meta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Meta(title: $title, description: $description, index: $index)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'index': index,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant Meta other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.index == index;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ index.hashCode;
}
