// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'photos_cubit.dart';

enum PhotosStatus { init, loading, loaded, error }

class PhotosState extends Equatable {
  const PhotosState(
      {this.photos = const [],
      this.status = PhotosStatus.init,
      this.currentPagePhotos = 1});

  final List<Photo> photos;
  final PhotosStatus status;
  final int currentPagePhotos;
  @override
  List<Object> get props => [photos, status,currentPagePhotos];

  PhotosState copyWith({
    List<Photo>? photos,
    PhotosStatus? status,
    int? currentPagePhotos
  }) {
    return PhotosState(
      photos: photos ?? this.photos,
      status: status ?? this.status,
      currentPagePhotos: currentPagePhotos ?? this.currentPagePhotos
    );
  }
}
