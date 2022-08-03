// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState(
      {this.status = StatusType.init,
      this.photos = const [],
      this.likePhotos = const [],
      this.collections = const []});
  final StatusType status;
  final List<Photo> photos;
  final List<Photo> likePhotos;
  final List<Collection> collections;

  @override
  List<Object> get props => [status, photos, likePhotos, collections];

  UserState copyWith({
    StatusType? status,
    List<Photo>? photos,
    List<Photo>? likePhotos,
    List<Collection>? collections,
  }) {
    return UserState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      likePhotos: likePhotos ?? this.likePhotos,
      collections: collections ?? this.collections,
    );
  }
}
