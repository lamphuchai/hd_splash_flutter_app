import '../constants/enum.dart';
import '../exceptions/unsplash_exception.dart';
import '../models/models.dart';
import '../network/dio_client.dart';


abstract class UsersAbs {
  Future<User> getUser({
    required String username,
  });

  Future<Map> getPortfolio({
    required String username,
  });

  Future<List<Photo>> getPhotos(
      {required String username,
      int page = 1,
      int perPage = 10,
      OrderBy orderBy = OrderBy.latest,
      bool stats = false,
      String resolution = "days",
      int quantity = 30,
      Orientation? orientation});

  Future<List<Photo>> getLikes(
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

  Future<Statistic> getStatistics({
    required String username,
    String resolution = "days",
    int quantity = 30,
  });
}

class Users extends UsersAbs {
  Users(this._dioClient);
  final DioClient _dioClient;
  @override
  Future<User> getUser({required String username}) async {
    final data = await _dioClient.get('/users/$username');
    return User.fromMap(data);
  }

  @override
  Future<Map> getPortfolio({required String username}) async {
    final data = await _dioClient.get('/users/$username/portfolio');
    return data;
  }

  @override
  Future<List<Photo>> getPhotos(
      {required String username,
      int page = 1,
      int perPage = 10,
      OrderBy orderBy = OrderBy.latest,
      bool stats = false,
      String resolution = "days",
      int quantity = 30,
      Orientation? orientation}) async {
    final data =
        await _dioClient.get('/users/$username/photos', queryParameters: {
      "page": page,
      "per_page": perPage,
      "order_by": orderBy.name,
      "stats": stats,
      "resolution": resolution,
      "quantity": quantity,
      "orientation": orientation?.name
    });

    return (data as List)
        .map((collection) => Photo.fromMap(collection))
        .toList();
  }

  @override
  Future<List<Photo>> getLikes(
      {required String username,
      int page = 1,
      int perPage = 10,
      LikesPhotosOrderBy orderBy = LikesPhotosOrderBy.latest,
      Orientation? orientation}) async {
    final data =
        await _dioClient.get('/users/$username/likes', queryParameters: {
      "page": page,
      "per_page": perPage,
      "order_by": orderBy.name,
      "orientation": orientation?.name
    });
    return (data as List)
        .map((collection) => Photo.fromMap(collection))
        .toList();
  }

  @override
  Future<List<Collection>> getCollections(
      {required String username, int page = 1, int perPage = 10}) async {
    final data =
        await _dioClient.get('/users/$username/collections', queryParameters: {
      "page": page,
      "per_page": perPage,
    });
    if (data == null) {
      throw const UnsplashException(message: "User no collections");
    }

    return (data as List)
        .map((collection) => Collection.fromMap(collection))
        .toList();
  }

  @override
  Future<Statistic> getStatistics(
      {required String username,
      String resolution = "days",
      int quantity = 30}) async {
    final data =
        await _dioClient.get('/users/$username/statistics', queryParameters: {
      "resolution": resolution,
      "quantity": quantity,
    });

    return Statistic.fromMap(data);
  }
}
