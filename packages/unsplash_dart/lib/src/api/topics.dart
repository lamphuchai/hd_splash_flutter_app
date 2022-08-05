import '../constants/enum.dart';
import '../models/models.dart';
import '../network/dio_client.dart';



abstract class TopicsAbs {
  Future<List<Topic>> topics(
      {List<String>? ids,
      int page = 1,
      int perPage = 10,
      OrderByTopic orderBy = OrderByTopic.position});

  Future<Topic> topic({
    required String id,
  });

  Future<List<Photo>> photos(
      {required String idTopic,
      int page = 1,
      int perPage = 10,
      Orientation? orientation,
      TopicPhotosOrderBy orderBy = TopicPhotosOrderBy.latest});
}

class Topics extends TopicsAbs {
  Topics(this._dioClient);
  final DioClient _dioClient;
  @override
  Future<List<Topic>> topics(
      {List<String>? ids,
      int page = 1,
      int perPage = 10,
      OrderByTopic orderBy = OrderByTopic.position}) async {
    final data = await _dioClient.get('/topics', queryParameters: {
      "ids": ids?.join(","),
      "page": page,
      "per_page": perPage,
      "order_by": orderBy.name
    });

    return (data as List)
        .map((collection) => Topic.fromMap(collection))
        .toList();
  }

  @override
  Future<Topic> topic({
    required String id,
  }) async {
    final data = await _dioClient.get(
      '/topics/$id',
    );
    return Topic.fromMap(data);
  }

  @override
  Future<List<Photo>> photos(
      {required String idTopic,
      int page = 1,
      int perPage = 10,
      Orientation? orientation,
      TopicPhotosOrderBy orderBy = TopicPhotosOrderBy.latest}) async {
    final data =
        await _dioClient.get('/topics/$idTopic/photos', queryParameters: {
      "page": page,
      "pre_page": perPage,
      "orientation": orientation?.name,
      "order_by": orderBy.name
    });

    return (data as List)
        .map((collection) => Photo.fromMap(collection))
        .toList();
  }
}
