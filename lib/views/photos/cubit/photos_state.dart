// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'photos_cubit.dart';

enum PhotosStatus { init, loading, loaded, error }

class PhotosState extends Equatable {
  const PhotosState({
    this.photos = const [],
    this.status = PhotosStatus.init,
  });

  final List<Photo> photos;
  final PhotosStatus status;
  @override
  List<Object> get props => [photos, status];

  PhotosState copyWith({
    List<Photo>? photos,
    PhotosStatus? status,
  }) {
    return PhotosState(
      photos: photos ?? this.photos,
      status: status ?? this.status,
    );
  }
}
