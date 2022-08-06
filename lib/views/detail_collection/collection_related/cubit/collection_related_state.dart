part of 'collection_related_cubit.dart';

class CollectionRelatedState extends Equatable {
  const CollectionRelatedState({
    this.collections = const [],
    this.status = StatusType.init,
  });
  final List<Collection> collections;
  final StatusType status;

  @override
  List<Object> get props => [collections, status];

  CollectionRelatedState copyWith({
    List<Collection>? collections,
    StatusType? status,
  }) {
    return CollectionRelatedState(
      collections: collections ?? this.collections,
      status: status ?? this.status,
    );
  }
}
