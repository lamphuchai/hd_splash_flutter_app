// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Mate {
  final String? title;
  final String? description;
  final bool index;
  Mate({
    required this.title,
    required this.description,
    required this.index,
  });

  Mate copyWith({
    String? title,
    String? description,
    bool? index,
  }) {
    return Mate(
      title: title ?? this.title,
      description: description ?? this.description,
      index: index ?? this.index,
    );
  }

  factory Mate.fromMap(Map<String, dynamic> map) {
    return Mate(
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      index: map['index'] as bool,
    );
  }

  factory Mate.fromJson(String source) =>
      Mate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Mate(title: $title, description: $description, index: $index)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'index': index,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant Mate other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.index == index;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ index.hashCode;
}
