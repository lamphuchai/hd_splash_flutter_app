// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_collection_cubit.dart';

class DetailCollectionState extends Equatable {
  const DetailCollectionState({
    this.statusType = StatusType.init,
    this.photos = const [],
  });
  final StatusType statusType;
  final List<Photo> photos;

  @override
  List<Object> get props => [statusType, photos];

  DetailCollectionState copyWith({
    StatusType? statusType,
    List<Photo>? photos,
  }) {
    return DetailCollectionState(
      statusType: statusType ?? this.statusType,
      photos: photos ?? this.photos,
    );
  }
}
