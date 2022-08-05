// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'photos_cubit.dart';

enum PhotosStatus { init, loading, loaded, error }

class PhotosState extends Equatable {
  const PhotosState(
      {this.photos = const [],
      this.status = PhotosStatus.init,
      this.orderBy = PhotosOrderBy.latest});

  final List<Photo> photos;
  final PhotosStatus status;
  final PhotosOrderBy orderBy;
  @override
  List<Object> get props => [photos, status, orderBy];

  PhotosState copyWith(
      {List<Photo>? photos, PhotosStatus? status, PhotosOrderBy? orderBy}) {
    return PhotosState(
        photos: photos ?? this.photos,
        status: status ?? this.status,
        orderBy: orderBy ?? this.orderBy);
  }
}
