import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unsplash_dart/src/exceptions/unsplash_exception.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../data_test.dart';
import 'collections_test.mocks.dart';

@GenerateMocks([Collections])
void main() {
  late MockCollections collectionsApi;
  setUp(() {
    collectionsApi = MockCollections();
  });

  group("get collections", () {
    test("success", () async {
      when(collectionsApi.getCollections()).thenAnswer((_) async => []);

      expect(await collectionsApi.getCollections(), isEmpty);

      when(collectionsApi.getCollections())
          .thenAnswer((_) async => [collection, collection]);

      final collections = await collectionsApi.getCollections();

      expect(collections, isA<List<Collection>>());
      expect(collections.length, 2);
    });
    test("failure", () async {
      when(collectionsApi.getCollections())
          .thenThrow(const UnsplashException(message: "err"));

      expect(() => collectionsApi.getCollections(),
          throwsA(isA<UnsplashException>()));
    });
  });

  group("collection by id", () {
    test("success", () async {
      when(collectionsApi.collectionById()).thenAnswer((_) async => collection);

      final col = await collectionsApi.collectionById();

      expect(col, isA<Collection>());
      expect(col.id, "274844");
      expect(col.title, "Express It");
    });
    test("failure", () async {
      when(collectionsApi.collectionById())
          .thenThrow(const UnsplashException(message: "err"));

      expect(() => collectionsApi.collectionById(),
          throwsA(isA<UnsplashException>()));
    });
  });
  group("get photos by collection", () {
    test("success", () async {
      when(collectionsApi.photosInCollectionById()).thenAnswer((_) async => []);
      expect(await collectionsApi.photosInCollectionById(), isEmpty);

      when(collectionsApi.photosInCollectionById())
          .thenAnswer((_) async => [photo, photo]);
      final photos = await collectionsApi.photosInCollectionById();
      expect(photos, isA<List<Photo>>());
      expect(photos.length, 2);
    });
    test("failure", () async {
      when(collectionsApi.photosInCollectionById())
          .thenThrow(const UnsplashException(message: "err"));
      expect(() => collectionsApi.photosInCollectionById(),
          throwsA(isA<UnsplashException>()));
    });
  });

  group("get relate collections", () {
    test("success", () async {
      when(collectionsApi.relatedCollectionsById()).thenAnswer((_) async => []);

      expect(await collectionsApi.relatedCollectionsById(), isEmpty);

      when(collectionsApi.relatedCollectionsById())
          .thenAnswer((_) async => [collection, collection, collection]);

      final collections = await collectionsApi.relatedCollectionsById();

      expect(collections, isA<List<Collection>>());
      expect(collections.length, 3);
    });
    test("failure", () async {
      when(collectionsApi.relatedCollectionsById())
          .thenThrow(const UnsplashException(message: "err"));

      expect(() => collectionsApi.relatedCollectionsById(),
          throwsA(isA<UnsplashException>()));
    });
  });
}
