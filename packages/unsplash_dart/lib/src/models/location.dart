import 'dart:convert';

class Location {
  const Location({
    this.latitude,
    this.longitude,
    this.name,
    this.city,
    this.country,
  });
  final String? latitude;
  final String? longitude;
  final String? name;
  final String? city;
  final String? country;

  Location copyWith({
    String? latitude,
    String? longitude,
    String? name,
    String? city,
    String? country,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'city': city,
      'country': country,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      latitude: map['position']["latitude"] != null
          ? map['position']["latitude"] as String
          : null,
      longitude: map['position']['longitude'] != null
          ? map['position']['longitude'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Location(latitude: $latitude, longitude: $longitude, name: $name, city: $city, country: $country)';
  }
}
