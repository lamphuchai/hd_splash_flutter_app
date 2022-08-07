import 'dart:convert';

class Exif {
  const Exif(
      {this.make,
      this.model,
      this.exposureTime,
      this.aperture,
      this.focalLength,
      this.isoSpeedEatings});
  final String? make;
  final String? model;
  final String? exposureTime;
  final String? aperture;
  final String? focalLength;
  final String? isoSpeedEatings;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'make': make,
      'model': model,
      'exposure_time': exposureTime,
      'aperture_value': aperture,
      'focal_length': focalLength,
      'iso_speed_ratings': isoSpeedEatings,
    };
  }

  factory Exif.fromMap(Map<String, dynamic> map) {
    return Exif(
      make: map['make'] != null ? map['make'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      exposureTime:
          map['exposure_time'] != null ? map['exposure_time'] as String : null,
      aperture: map['aperture'] != null ? map['aperture'] as String : null,
      focalLength:
          map['focal_length'] != null ? map['focal_length'] as String : null,
      isoSpeedEatings: map['iso'] != null ? map['iso'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exif.fromJson(String source) =>
      Exif.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Exif(make: $make, model: $model, exposureTime: $exposureTime, aperture: $aperture, focalLength: $focalLength, isoSpeedEatings: $isoSpeedEatings)';
  }
}
