import '../constants/enum.dart';
import '../models/models.dart';
import '../network/dio_client.dart';



abstract class SearchAbs {
  Future<List<Photo>> photos(
      {required String query,
      int page = 1,
      int perPage = 10,
      OrderBySearch orderBy = OrderBySearch.relevant,
      List<String> collections = const [],
      ContentFilter contentFilter = ContentFilter.low,
      ColorUnsplash? color,
      Orientation? orientation,
      String lang = "en"});

  Future<List<Collection>> collections({
    required String query,
    int page = 1,
    int perPage = 10,
  });

  Future<List<User>> users({
    required String query,
    int page = 1,
    int perPage = 10,
  });
}

class Search extends SearchAbs {
  Search(this._dioClient);
  final DioClient _dioClient;
  @override
  Future<List<Photo>> photos(
      {required String query,
      int page = 1,
      int perPage = 10,
      OrderBySearch orderBy = OrderBySearch.relevant,
      List<String>? collections,
      ContentFilter contentFilter = ContentFilter.low,
      ColorUnsplash? color,
      Orientation? orientation,
      String lang = "en"}) async {
    final data = await _dioClient.get('/search/photos', queryParameters: {
      "query": query,
      "page": page,
      "per_page": perPage,
      "order_by": orderBy.name,
      "collections": collections?.join(','),
      "content_filter": contentFilter.name,
      "color": color?.name,
      "orientation": orientation?.name,
      "lang": lang
    });
    return (data["results"] as List)
        .map((photo) => Photo.fromMap(photo))
        .toList();
  }

  @override
  Future<List<Collection>> collections({
    required String query,
    int page = 1,
    int perPage = 10,
  }) async {
    final data = await _dioClient.get('/search/collections', queryParameters: {
      "query": query,
      "page": page,
      "per_page": perPage,
    });
    return (data["results"] as List)
        .map((photo) => Collection.fromMap(photo))
        .toList();
  }

  @override
  Future<List<User>> users(
      {required String query, int page = 1, int perPage = 10}) async {
    final data = await _dioClient.get('/search/users', queryParameters: {
      "query": query,
      "page": page,
      "per_page": perPage,
    });
    return (data["results"] as List)
        .map((photo) => User.fromMap(photo))
        .toList();
  }
}
