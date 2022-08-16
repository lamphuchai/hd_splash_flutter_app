// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'topics_cubit.dart';


class TopicsState extends Equatable {
  const TopicsState(
      {this.topics = const [],
      this.status = StatusType.init,
      this.orderBy = TopicsOrderBy.position});
  final List<Topic> topics;
  final StatusType status;

  final TopicsOrderBy orderBy;

  @override
  List<Object> get props => [topics, status, orderBy];

  TopicsState copyWith(
      {List<Topic>? topics, StatusType? status, TopicsOrderBy? orderBy}) {
    return TopicsState(
        topics: topics ?? this.topics,
        status: status ?? this.status,
        orderBy: orderBy ?? this.orderBy);
  }
}
