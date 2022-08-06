
import 'package:dio/dio.dart';

import '../constants/enum.dart';
import '../exceptions/unsplash_exception.dart';
import '../models/models.dart';
import '../network/dio_client.dart';

abstract class PhotosAbs {
  Future<List<Photo>> getPhotos({
    int page = 1,
    int perPage = 10,
    PhotosOrderBy orderBy = PhotosOrderBy.latest,
  });

  Future<Photo> photoById({
    required String id,
  });

  Future<Photo> randomPhoto(
      {List<String> collections = const [],
      List<String> topics = const [],
      String? username,
      String? query,
      Orientation? orientation,
      ContentFilter contentFilter = ContentFilter.low});

  Future<List<Photo>> randomPhotos(
      {List<String> collections = const [],
      List<String> topics = const [],
      String? username,
      String? query,
      Orientation? orientation,
      ContentFilter contentFilter = ContentFilter.low,
      int count = 1});

  Future<Statistic> getStatistics({
    required String id,
    String resolution = "days",
    int quantity = 30,
  });

  Future<Photo> updatePhoto(
      {required String id,
      required String accessToken,
      String? description,
      bool? showOnProfile,
      String? tags,
      Location? location,
      Exif? exif});

  Future<Photo> likePhoto({
    required String id,
    required String accessToken,
  });

  Future<Photo> unlikePhoto({
    required String id,
    required String accessToken,
  });
}

class Photos extends PhotosAbs {
  Photos(this._dioClient);
  final DioClient _dioClient;
  @override
  Future<List<Photo>> getPhotos(
      {int page = 1,
      int perPage = 10,
      PhotosOrderBy orderBy = PhotosOrderBy.latest}) async {
    final data = await _dioClient.get('/photos', queryParameters: {
      "page": page,
      "per_page": perPage,
      "order_by": orderBy.name,
    });
    return (data as List).map((photo) => Photo.fromMap(photo)).toList();
  }

  @override
  Future<Photo> photoById({required String id}) async {
    final photo = await _dioClient.get('/photos/$id', queryParameters: {
      "id": id,
    });
    return Photo.fromMap(photo);
  }

  @override
  Future<Photo> randomPhoto({
    List<String>? collections,
    List<String>? topics,
    String? username,
    String? query,
    Orientation? orientation,
    ContentFilter contentFilter = ContentFilter.low,
  }) async {
    final photo = await _dioClient.get('/photos/random', queryParameters: {
      "collections": collections?.join(","),
      "topics": topics?.join(","),
      "username": username,
      "query": query,
      "orientation": orientation?.name,
      "content_filter": contentFilter.name,
    });
    return Photo.fromMap(photo);
  }

  @override
  Future<List<Photo>> randomPhotos(
      {List<String>? collections,
      List<String>? topics,
      String? username,
      String? query,
      Orientation? orientation,
      ContentFilter contentFilter = ContentFilter.low,
      int count = 1}) async {
    if (count > 1 && count > 30) {
      throw const UnsplashException(message: "Count min = 1,max = 30");
    }
    final data = await _dioClient.get('/photos/random', queryParameters: {
      "collections": collections?.join(","),
      "topics": topics?.join(","),
      "username": username,
      "query": query,
      "orientation": orientation?.name,
      "content_filter": contentFilter.name,
      "count": count
    });
    return (data as List).map((photo) => Photo.fromMap(photo)).toList();
  }

  @override
  Future<Statistic> getStatistics(
      {required String id,
      String resolution = "days",
      int quantity = 30}) async {
    final data = await _dioClient.get('/photos/$id/statistics',
        queryParameters: {
          "id": id,
          "resolution": resolution,
          "quantity": quantity
        });
    return Statistic.fromMap(data);
  }

  @override
  Future<Photo> updatePhoto(
      {required String id,
      required String accessToken,
      String? description,
      bool? showOnProfile,
      String? tags,
      Location? location,
      Exif? exif}) async {
    final data = await _dioClient.put('/photos/$id',
        options: Options(headers: {"Authorization": 'Bearer $accessToken'}),
        queryParameters: {
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
    required String accessToken,
  }) async {
    final data = await _dioClient.post(
      '/photos/$id/like',
      options: Options(headers: {"Authorization": 'Bearer $accessToken'}),
    );
    return Photo.fromMap(data);
  }

  @override
  Future<Photo> unlikePhoto({
    required String id,
    required String accessToken,
  }) async {
    final data = await _dioClient.delete(
      '/photos/$id/like',
      options: Options(headers: {"Authorization": 'Bearer $accessToken'}),
    );
    return Photo.fromMap(data);
  }
}
