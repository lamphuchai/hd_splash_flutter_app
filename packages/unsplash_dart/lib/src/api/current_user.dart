import 'dart:async';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../network/dio_client.dart';

abstract class UserImp {
  Stream<User?> get userChange;
  Future<User?> getCurrentUser();
  Future<User> updateCurrentUser({
    required String username,
    String? firstName,
    String? lastName,
    required String email,
    String? url,
    String? location,
    String? bio,
    String? instagramUsername,
  });
  Future<List<Photo>> getPhotos(
      {required String username,
      int page = 1,
      int perPage = 10,
      UserOrderBy orderBy = UserOrderBy.latest,
      bool stats = false,
      String resolution = "days",
      int quantity = 30,
      Orientation? orientation});
  Future<Photo> updatePhoto(
      {required String id,
      String? description,
      bool? showOnProfile,
      String? tags,
      Location? location,
      Exif? exif});

  Future<Photo> likePhoto({
    required String id,
  });

  Future<Photo> unlikePhoto({
    required String id,
  });
  Future<List<Photo>> getLikesPhotos(
      {required String username,
      int page = 1,
      int perPage = 10,
      LikesPhotosOrderBy orderBy = LikesPhotosOrderBy.latest,
      Orientation? orientation});

  Future<List<Collection>> getCollections({
    required String username,
    int page = 1,
    int perPage = 10,
  });
}

class CurrentUser implements UserImp {
  CurrentUser(this._dioClient);
  final DioClient _dioClient;
  final StreamController<User> _controller = StreamController<User>.broadcast();
  @override
  Stream<User> get userChange => _controller.stream;
  @override
  Future<User?> getCurrentUser() async {
    final data = await _dioClient.get(
      '/me',
    );
    if (data is Map) {
      final user = User.fromMap((data as Map<String, dynamic>));
      _controller.add(user);
      return user;
    }
    return null;
  }

  @override
  Future<User> updateCurrentUser(
      {required String username,
      String? firstName,
      String? lastName,
      required String email,
      String? url,
      String? location,
      String? bio,
      String? instagramUsername}) async {
    final data = await _dioClient.put('/me', queryParameters: {
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "url": url,
      "location": location,
      "bio": bio,
      "instagram_username": instagramUsername,
    });
    final user = User.fromMap(data);
    _controller.add(user);
    return user;
  }

  @override
  Future<List<Collection>> getCollections(
      {required String username, int page = 1, int perPage = 10}) async {
    final data = await _dioClient.get('/users/$username/collections',
        queryParameters: {"per_page": perPage});
    return (data as List)
        .map((collection) => Collection.fromMap(collection))
        .toList();
  }

  @override
  Future<List<Photo>> getLikesPhotos(
      {required String username,
      int page = 1,
      int perPage = 10,
      LikesPhotosOrderBy orderBy = LikesPhotosOrderBy.latest,
      Orientation? orientation}) async {
    final data = await _dioClient
        .get('/users/$username/likes', queryParameters: {"per_page": perPage});
    return (data as List).map((photo) => Photo.fromMap(photo)).toList();
  }

  @override
  Future<List<Photo>> getPhotos(
      {required String username,
      int page = 1,
      int perPage = 10,
      UserOrderBy orderBy = UserOrderBy.latest,
      bool stats = false,
      String resolution = "days",
      int quantity = 30,
      Orientation? orientation}) async {
    final data = await _dioClient
        .get('/users/$username/photos', queryParameters: {"per_page": perPage});
    return (data as List).map((photo) => Photo.fromMap(photo)).toList();
  }

  @override
  Future<Photo> updatePhoto(
      {required String id,
      String? description,
      bool? showOnProfile,
      String? tags,
      Location? location,
      Exif? exif}) async {
    final data = await _dioClient.put('/photos/$id', queryParameters: {
      "description": description,
      "tags": tags,
      "location[latitude]": location?.latitude,
      "location[longitude]": location?.longitude,
      "location[name]": location?.name,
      "location[city]": location?.city,
      "location[country]": location?.country,
      "exif[make]": exif?.make,
      "exif[model]": exif?.model,
      "exif[exposure_time]": exif?.exposureTime,
      "exif[aperture_value]": exif?.aperture,
      "exif[focal_length]": exif?.focalLength,
      "exif[iso_speed_ratings]": exif?.isoSpeedEatings,
    });

    return Photo.fromMap(data);
  }

  @override
  Future<Photo> likePhoto({
    required String id,
  }) async {
    final data = await _dioClient.post(
      '/photos/$id/like',
    );
    return Photo.fromMap(data["photo"]);
  }

  @override
  Future<Photo> unlikePhoto({
    required String id,
  }) async {
    final data = await _dioClient.delete(
      '/photos/$id/like',
    );
    return Photo.fromMap(data["photo"]);
  }

  void dispose() {
    _controller.close();
  }
}
