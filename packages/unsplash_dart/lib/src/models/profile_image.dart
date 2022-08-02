import 'dart:convert';

class ProfileImage {
  final String small;
  final String medium;
  final String large;
  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  ProfileImage copyWith({
    String? small,
    String? medium,
    String? large,
  }) {
    return ProfileImage(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'small': small,
      'medium': medium,
      'large': large,
    };
  }

  factory ProfileImage.fromMap(Map<String, dynamic> map) {
    return ProfileImage(
      small: map['small'] ?? '',
      medium: map['medium'] ?? '',
      large: map['large'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileImage.fromJson(String source) =>
      ProfileImage.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProfileImage(small: $small, medium: $medium, large: $large)';


}
