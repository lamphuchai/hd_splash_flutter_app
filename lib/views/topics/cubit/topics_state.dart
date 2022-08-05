// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'topics_cubit.dart';

enum TopicsStatus { init, loading, loaded, error }

class TopicsState extends Equatable {
  const TopicsState(
      {this.topics = const [],
      this.status = TopicsStatus.init,
      this.orderBy = OrderByTopic.position});
  final List<Topic> topics;
  final TopicsStatus status;

  final OrderByTopic orderBy;

  @override
  List<Object> get props => [topics, status, orderBy];

  TopicsState copyWith(
      {List<Topic>? topics, TopicsStatus? status, OrderByTopic? orderBy}) {
    return TopicsState(
        topics: topics ?? this.topics,
        status: status ?? this.status,
        orderBy: orderBy ?? this.orderBy);
  }
}
