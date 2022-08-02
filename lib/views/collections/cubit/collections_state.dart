// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'collections_cubit.dart';

enum CollectionsStatus { init, loading, loaded, error }

class CollectionsState extends Equatable {
  const CollectionsState(
      {this.collections = const [],
      this.status = CollectionsStatus.init,
      this.currentPageCollection = 1});
  final List<Collection> collections;
  final CollectionsStatus status;
  final int currentPageCollection;

  @override
  List<Object> get props => [collections, status, currentPageCollection];

  CollectionsState copyWith({
    List<Collection>? collections,
    CollectionsStatus? status,
    int? currentPageCollection,
  }) {
    return CollectionsState(
      collections: collections ?? this.collections,
      status: status ?? this.status,
      currentPageCollection:
          currentPageCollection ?? this.currentPageCollection,
    );
  }
}
