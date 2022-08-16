// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_collection_cubit.dart';

enum ActionCollection { none, deleteCollection,updateCollection, actionError }

class DetailCollectionState extends Equatable {
  const DetailCollectionState(
      {required this.collection,
      this.statusType = StatusType.init,
      this.photos = const [],
      this.actionCollection = ActionCollection.none,
      this.relatedCollections = const []});
  final Collection collection;
  final StatusType statusType;
  final List<Photo> photos;
  final ActionCollection actionCollection;
  final List<Collection> relatedCollections;

  @override
  List<Object> get props =>
      [statusType, photos, collection, actionCollection, relatedCollections];

  DetailCollectionState copyWith(
      {StatusType? statusType,
      List<Photo>? photos,
      Collection? collection,
      ActionCollection? actionCollection,
      List<Collection>? relatedCollections}) {
    return DetailCollectionState(
        actionCollection: actionCollection ?? this.actionCollection,
        statusType: statusType ?? this.statusType,
        photos: photos ?? this.photos,
        collection: collection ?? this.collection,
        relatedCollections: relatedCollections ?? this.relatedCollections);
  }
}
