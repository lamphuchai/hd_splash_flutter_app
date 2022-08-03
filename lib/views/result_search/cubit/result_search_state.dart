// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'result_search_cubit.dart';

class ResultSearchState extends Equatable {
  const ResultSearchState(
      {this.status = StatusType.init,
      this.photos = const [],
      this.users = const [],
      this.collections = const []});
  final StatusType status;
  final List<Photo> photos;
  final List<User> users;
  final List<Collection> collections;
  @override
  List<Object> get props => [status, photos, users, collections];

  ResultSearchState copyWith({
    StatusType? status,
    List<Photo>? photos,
    List<User>? users,
    List<Collection>? collections,
  }) {
    return ResultSearchState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      users: users ?? this.users,
      collections: collections ?? this.collections,
    );
  }
}
