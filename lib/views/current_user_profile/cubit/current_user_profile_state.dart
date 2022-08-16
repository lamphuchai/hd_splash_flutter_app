// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_user_profile_cubit.dart';

class CurrentUserProfileState extends Equatable {
  const CurrentUserProfileState(
      {this.statusType = StatusType.init,
      this.photos = const [],
      this.likePhotos = const [],
      this.collections = const []});
  final StatusType statusType;
  final List<Photo> photos;
  final List<Photo> likePhotos;
  final List<Collection> collections;
  @override
  List<Object> get props => [statusType, photos, likePhotos, collections];

  CurrentUserProfileState copyWith({
    StatusType? statusType,
    List<Photo>? photos,
    List<Photo>? likePhotos,
    List<Collection>? collections,
  }) {
    return CurrentUserProfileState(
      statusType: statusType ?? this.statusType,
      photos: photos ?? this.photos,
      likePhotos: likePhotos ?? this.likePhotos,
      collections: collections ?? this.collections,
      
    );
  }
}
