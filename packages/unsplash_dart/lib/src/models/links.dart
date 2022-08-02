import 'dart:convert';

class Links {
  final String self;
  final String html;
  final String download;
  final String? downloadLocation;
  final String? related;
  final String? photos;
  Links({
    required this.self,
    required this.html,
    required this.download,
    this.downloadLocation,
    this.related,
    this.photos,
  });

  Links copyWith({
    String? self,
    String? html,
    String? download,
    String? downloadLocation,
    String? related,
    String? photos,
  }) {
    return Links(
      self: self ?? this.self,
      html: html ?? this.html,
      download: download ?? this.download,
      downloadLocation: downloadLocation ?? this.downloadLocation,
      related: related ?? this.related,
      photos: photos ?? this.photos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'self': self,
      'html': html,
      'download': download,
      'download_location': downloadLocation,
      'related': related,
      'photos': photos,
    };
  }

  factory Links.fromMap(Map<String, dynamic> map) {
    return Links(
      self: map['self'] ?? '',
      html: map['html'] ?? '',
      download: map['download'] ?? '',
      downloadLocation: map['download_location'],
      related: map['related'],
      photos: map['photos'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Links.fromJson(String source) => Links.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Links(self: $self, html: $html, download: $download, downloadLocation: $downloadLocation, related: $related, photos: $photos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Links &&
        other.self == self &&
        other.html == html &&
        other.download == download &&
        other.downloadLocation == downloadLocation &&
        other.related == related &&
        other.photos == photos;
  }

  @override
  int get hashCode {
    return self.hashCode ^
        html.hashCode ^
        download.hashCode ^
        downloadLocation.hashCode ^
        related.hashCode ^
        photos.hashCode;
  }
}
