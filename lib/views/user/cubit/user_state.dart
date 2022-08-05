// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState(
      {this.status = StatusType.init,
      this.photos = const [],
      this.likePhotos = const [],
      this.collections = const [],
      this.photosOrderBy = OrderBy.latest,
      this.likesOrderBy = LikesPhotosOrderBy.latest});
  final StatusType status;
  final List<Photo> photos;
  final List<Photo> likePhotos;
  final List<Collection> collections;
  final OrderBy photosOrderBy;
  final LikesPhotosOrderBy likesOrderBy;

  @override
  List<Object> get props =>
      [status, photos, likePhotos, collections, photosOrderBy, likesOrderBy];

  UserState copyWith(
      {StatusType? status,
      List<Photo>? photos,
      List<Photo>? likePhotos,
      List<Collection>? collections,
      OrderBy? photosOrderBy,
      LikesPhotosOrderBy? likesOrderBy}) {
    return UserState(
        status: status ?? this.status,
        photos: photos ?? this.photos,
        likePhotos: likePhotos ?? this.likePhotos,
        collections: collections ?? this.collections,
        photosOrderBy: photosOrderBy ?? this.photosOrderBy,
        likesOrderBy: likesOrderBy ?? this.likesOrderBy);
  }
}
