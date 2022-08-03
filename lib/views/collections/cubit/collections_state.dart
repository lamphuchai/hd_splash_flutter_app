// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'collections_cubit.dart';

enum CollectionsStatus { init, loading, loaded, error }

class CollectionsState extends Equatable {
  const CollectionsState({
    this.collections = const [],
    this.status = CollectionsStatus.init,
  });
  final List<Collection> collections;
  final CollectionsStatus status;

  @override
  List<Object> get props => [collections, status];

  CollectionsState copyWith({
    List<Collection>? collections,
    CollectionsStatus? status,
  }) {
    return CollectionsState(
      collections: collections ?? this.collections,
      status: status ?? this.status,
    );
  }
}
