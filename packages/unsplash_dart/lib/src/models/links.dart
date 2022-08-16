// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Links {
  final String self;
  final String html;
  final String download;
  final String? downloadLocation;
  final String? related;
  final String? photos;
  String? portfolio;
  String? following;
  String? followers;
  Links(
      {required this.self,
      required this.html,
      required this.download,
      this.downloadLocation,
      this.related,
      this.photos,
      this.portfolio,
      this.following,
      this.followers});

  Links copyWith({
    String? self,
    String? html,
    String? download,
    String? downloadLocation,
    String? related,
    String? photos,
    String? portfolio,
    String? following,
    String? followers,
  }) {
    return Links(
        self: self ?? this.self,
        html: html ?? this.html,
        download: download ?? this.download,
        downloadLocation: downloadLocation ?? this.downloadLocation,
        related: related ?? this.related,
        photos: photos ?? this.photos,
        portfolio: portfolio ?? this.portfolio,
        following: following ?? this.following,
        followers: followers ?? this.followers);
  }

  Map<String, dynamic> toMap() {
    return {
      'self': self,
      'html': html,
      'download': download,
      'download_location': downloadLocation,
      'related': related,
      'photos': photos,
      'portfolio': portfolio,
      'following': following,
      'followers': followers,
    };
  }

  factory Links.fromMap(Map<String, dynamic> map) {
    return Links(
      self: map['self'] ?? 'https://unsplash.com/',
      html: map['html'] ?? 'https://unsplash.com/',
      download: map['download'] ?? 'https://unsplash.com/',
      downloadLocation: map['download_location'],
      related: map['related'],
      photos: map['photos'],
      portfolio: map['portfolio'],
      following: map['following'],
      followers: map['followers'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Links.fromJson(String source) => Links.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Links(self: $self, html: $html, download: $download, downloadLocation: $downloadLocation, related: $related, photos: $photos)';
  }

  @override
  bool operator ==(covariant Links other) {
    if (identical(this, other)) return true;
  
    return 
      other.self == self &&
      other.html == html &&
      other.download == download &&
      other.downloadLocation == downloadLocation &&
      other.related == related &&
      other.photos == photos &&
      other.portfolio == portfolio &&
      other.following == following &&
      other.followers == followers;
  }

  @override
  int get hashCode {
    return self.hashCode ^
      html.hashCode ^
      download.hashCode ^
      downloadLocation.hashCode ^
      related.hashCode ^
      photos.hashCode ^
      portfolio.hashCode ^
      following.hashCode ^
      followers.hashCode;
  }
}
