// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'collections_cubit.dart';


class CollectionsState extends Equatable {
  const CollectionsState({
    this.collections = const [],
    this.status = StatusType.init,
  });
  final List<Collection> collections;
  final StatusType status;

  @override
  List<Object> get props => [collections, status];

  CollectionsState copyWith({
    List<Collection>? collections,
    StatusType? status,
  }) {
    return CollectionsState(
      collections: collections ?? this.collections,
      status: status ?? this.status,
    );
  }
}
