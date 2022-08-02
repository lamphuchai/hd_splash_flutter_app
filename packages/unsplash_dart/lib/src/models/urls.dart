// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Urls {
  const Urls(
      {required this.raw,
      required this.full,
      required this.regular,
      required this.small,
      required this.thumb,
      required this.smallS3});

  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String smallS3;

  Urls copyWith({
    String? raw,
    String? full,
    String? regular,
    String? small,
    String? thumb,
    String? smallS3,
  }) {
    return Urls(
      raw: raw ?? this.raw,
      full: full ?? this.full,
      regular: regular ?? this.regular,
      small: small ?? this.small,
      thumb: thumb ?? this.thumb,
      smallS3: smallS3 ?? this.smallS3,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'raw': raw,
      'full': full,
      'regular': regular,
      'small': small,
      'thumb': thumb,
      'smallS3': smallS3,
    };
  }

  factory Urls.fromMap(Map<String, dynamic> map) {
    return Urls(
      raw: map['raw'] as String,
      full: map['full'] as String,
      regular: map['regular'] as String,
      small: map['small'] as String,
      thumb: map['thumb'] as String,
      smallS3: map['small_s3'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Urls.fromJson(String source) =>
      Urls.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Urls(raw: $raw, full: $full, regular: $regular, small: $small, thumb: $thumb, smallS3: $smallS3)';
  }
}
