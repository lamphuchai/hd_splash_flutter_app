// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_collection_cubit.dart';

enum StatusType { init, loading, loaded, error }

class DetailCollectionState extends Equatable {
  const DetailCollectionState(
      {required this.collection, this.statusType = StatusType.init, this.photos = const []});
  final StatusType statusType;
  final List<Photo> photos;
  final Collection collection;

  @override
  List<Object> get props => [statusType, photos];

  DetailCollectionState copyWith({
    StatusType? statusType,
    List<Photo>? photos,
    Collection ?collection
  }) {
    return DetailCollectionState(
      statusType: statusType ?? this.statusType,
      photos: photos ?? this.photos,
      collection: collection ?? this.collection
    );
  }
}
