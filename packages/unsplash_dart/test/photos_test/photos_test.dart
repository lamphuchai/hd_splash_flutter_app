import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unsplash_dart/src/exceptions/unsplash_exception.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

import '../data_test.dart';
import 'photos_test.mocks.dart';

@GenerateMocks([Photos])
void main() {
  late MockPhotos photosApi;
  setUp(() {
    photosApi = MockPhotos();
  });

  group("get photos", () {
    test("empty", () async {
      // when(photosApi.getPhotos()).thenAnswer((realInvocation) async => []);
      List<String> fullScope = [
        "public",
        "read_user",
        "write_user",
        "read_photos",
        "write_photos",
        "write_likes",
        "write_followers",
        "read_collections",
        "write_collections",
      ];
      print(fullScope.join("+"));
      // expect(await photosApi.getPhotos(), isEmpty);
    });
    test("success", () async {
      when(photosApi.getPhotos())
          .thenAnswer((realInvocation) async => [photo, photo, photo]);
      final photos = await photosApi.getPhotos();

      expect(photos, isA<List<Photo>>());

      expect(photos.length, 3);
    });
    test("failed", () async {
      when(photosApi.getPhotos())
          .thenThrow(const UnsplashException(message: "err"));

      expect(() => photosApi.getPhotos(),
          throwsA(const UnsplashException(message: "err")));
    });
  });
  group("photo by id", () {
    test("success", () async {
      when(photosApi.photoById()).thenAnswer((realInvocation) async => photo);

      final photoById = await photosApi.photoById();

      expect(photoById, isA<Photo>());
      expect(photoById.id, "WO4rscEPygA");
      expect(photoById.tags.length, 2);
    });

    test("failed", () async {
      when(photosApi.photoById())
          .thenThrow(const UnsplashException(message: "err"));

      expect(() => photosApi.photoById(), throwsA(isA<UnsplashException>()));
    });
  });
  group("random photo", () {
    test("success", () async {
      when(photosApi.randomPhoto()).thenAnswer((realInvocation) async => photo);
      expect(await photosApi.randomPhoto(), isA<Photo>());
    });

    test("failure", () async {
      when(photosApi.randomPhoto())
          .thenThrow(const UnsplashException(message: "err"));
      expect(() => photosApi.randomPhoto(), throwsException);
    });
  });

  group("random photos", () {
    test("success", () async {
      when(photosApi.randomPhotos()).thenAnswer((realInvocation) async => []);
      expect(await photosApi.randomPhotos(), isEmpty);

      when(photosApi.randomPhotos())
          .thenAnswer((realInvocation) async => [photo]);
      expect(await photosApi.randomPhotos(), isA<List<Photo>>());

      when(photosApi.randomPhotos())
          .thenAnswer((realInvocation) async => [photo, photo, photo, photo]);
      final photos = await photosApi.randomPhotos();
      expect(photos.length, 4);
    });

    test("failure", () async {
      when(photosApi.randomPhotos())
          .thenThrow(const UnsplashException(message: "err"));
      expect(() => photosApi.randomPhotos(), throwsException);
    });
  });
  group("update photo", () {
    test("success", () async {
      when(photosApi.updatePhoto()).thenAnswer((realInvocation) async => photo);
      expect(await photosApi.updatePhoto(), isA<Photo>());
    });
    test("failure", () async {
      when(photosApi.updatePhoto())
          .thenThrow(const UnsplashException(message: "err"));
      expect(() => photosApi.updatePhoto(), throwsA(isA<UnsplashException>()));
    });
  });
  group("like photo", () {
    test("success", () async {
      when(photosApi.likePhoto()).thenAnswer((realInvocation) async => photo);
      expect(await photosApi.likePhoto(), isA<Photo>());
    });
    test("failure", () async {
      when(photosApi.likePhoto())
          .thenThrow(const UnsplashException(message: "err"));
      expect(() => photosApi.likePhoto(), throwsA(isA<UnsplashException>()));
    });
  });
  group("unlike photo", () {
    test("success", () async {
      when(photosApi.unlikePhoto()).thenAnswer((realInvocation) async => photo);
      expect(await photosApi.unlikePhoto(), isA<Photo>());
    });
    test("failure", () async {
      when(photosApi.unlikePhoto())
          .thenThrow(const UnsplashException(message: "err"));
      expect(() => photosApi.unlikePhoto(), throwsA(isA<UnsplashException>()));
    });
  });
}
