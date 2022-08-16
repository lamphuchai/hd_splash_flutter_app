import '../constants/enum.dart';
import '../models/models.dart';
import '../network/dio_client.dart';

abstract class CollectionsAbs {
  Future<List<Collection>> getCollections({int page = 1, int perPage = 10});

  Future<Collection> getCollectionById(
      {required String id, int page = 1, int perPage = 10});

  Future<List<Photo>> getPhotosByCollection(
      {required String id,
      int page = 1,
      int perPage = 10,
      Orientation? orientation});

  Future<List<Collection>> getRelatedCollections({
    required String id,
  });

  // USING AUTHEN ACCESS_TOKEN LOGIN USER

  Future<Collection> createCollection(
      {required String title, String? description, bool? private});

  Future<Collection> updateCollection(
      {required String id, String? title, String? description, bool? private});

  Future<bool> deleteCollection({
    required String id,
  });

  Future<Map<String, dynamic>> addPhotoCollection({
    required String collectionId,
    required String photoId,
  });

  Future<Map<String, dynamic>> removePhotoCollection({
    required String collectionId,
    required String photoId,
  });
}

class Collections extends CollectionsAbs {
  Collections(this._dioClient);
  final DioClient _dioClient;
  @override
  Future<List<Collection>> getCollections(
      {int page = 1, int perPage = 10}) async {
    final data = await _dioClient.get("/collections",
        queryParameters: {"page": page, "per_page": perPage});
    return (data as List)
        .map((collection) => Collection.fromMap(collection))
        .toList();
  }

  @override
  Future<Collection> getCollectionById(
      {required String id, int page = 1, int perPage = 10}) async {
    final data = await _dioClient.get('/collections/$id',
        queryParameters: {"page": page, "per_page": perPage});

    return Collection.fromMap(data);
  }

  @override
  Future<List<Photo>> getPhotosByCollection(
      {required String id,
      int page = 1,
      int perPage = 10,
      Orientation? orientation}) async {
    final data = await _dioClient.get('/collections/$id/photos',
        queryParameters: {
          "page": page,
          "per_page": perPage,
          "orientation": orientation?.name
        });

    return (data as List)
        .map((collection) => Photo.fromMap(collection))
        .toList();
  }

  @override
  Future<List<Collection>> getRelatedCollections({required String id}) async {
    final data =
        await _dioClient.get('/collections/$id/related', queryParameters: {});
    return (data as List)
        .map((collection) => Collection.fromMap(collection))
        .toList();
  }

  @override
  Future<Collection> createCollection(
      {required String title, String? description, bool? private}) async {
    final data = await _dioClient.post('/collections', queryParameters: {
      "title": title,
      "description": description,
      "private": private
    });

    return Collection.fromMap(data);
  }

  @override
  Future<Collection> updateCollection(
      {required String id,
      String? title,
      String? description,
      bool? private}) async {
    final data = await _dioClient.put('/collections/$id', queryParameters: {
      "title": title,
      "description": description,
      "private": private
    });
    return Collection.fromMap(data);
  }

  @override
  Future<bool> deleteCollection({required String id}) async {
    await _dioClient.delete('/collections/$id', queryParameters: {"id": id});
    return true;
  }

  @override
  Future<Map<String, dynamic>> addPhotoCollection({
    required String collectionId,
    required String photoId,
  }) async {
    final data = await _dioClient.post('/collections/$collectionId/add',
        queryParameters: {"collection_id": collectionId, "photo_id": photoId});

    return data;
  }

  @override
  Future<Map<String, dynamic>> removePhotoCollection({
    required String collectionId,
    required String photoId,
  }) async {
    final data = await _dioClient.delete('/collections/$collectionId/remove',
        queryParameters: {"collection_id": collectionId, "photo_id": photoId});
    return data;
  }
}
