// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'models.dart';



class Sponsorship {
  final List<String> impressionUrls;
  final String tagline;
  final String taglineUrl;
  final User sponsor;
  Sponsorship({
    required this.impressionUrls,
    required this.tagline,
    required this.taglineUrl,
    required this.sponsor,
  });

  Sponsorship copyWith({
    List<String>? impressionUrls,
    String? tagline,
    String? taglineUrl,
    User? sponsor,
  }) {
    return Sponsorship(
      impressionUrls: impressionUrls ?? this.impressionUrls,
      tagline: tagline ?? this.tagline,
      taglineUrl: taglineUrl ?? this.taglineUrl,
      sponsor: sponsor ?? this.sponsor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'impression_urls': impressionUrls,
      'tagline': tagline,
      'tagline_url': taglineUrl,
      'sponsor': sponsor.toMap(),
    };
  }

  factory Sponsorship.fromMap(Map<String, dynamic> map) {
    return Sponsorship(
      impressionUrls: List<String>.from(
        map['impression_urls'],
      ),
      tagline: map['tagline'] as String,
      taglineUrl: map['tagline_url'] as String,
      sponsor: User.fromMap(map['sponsor'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sponsorship.fromJson(String source) =>
      Sponsorship.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Sponsorship(impressionUrls: $impressionUrls, tagline: $tagline, taglineUrl: $taglineUrl, sponsor: $sponsor)';
  }

}
