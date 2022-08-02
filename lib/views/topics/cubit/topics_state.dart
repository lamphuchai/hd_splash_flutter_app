// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'topics_cubit.dart';

enum TopicsStatus { init, loading, loaded, error }

class TopicsState extends Equatable {
  const TopicsState(
      {this.topics = const [],
      this.status = TopicsStatus.init,
      this.currentPageTopics = 1});
  final List<Topic> topics;
  final TopicsStatus status;
  final int currentPageTopics;

  @override
  List<Object> get props => [topics, status, currentPageTopics];

  TopicsState copyWith({
    List<Topic>? topics,
    TopicsStatus? status,
    int? currentPageTopics,
  }) {
    return TopicsState(
      topics: topics ?? this.topics,
      status: status ?? this.status,
      currentPageTopics: currentPageTopics ?? this.currentPageTopics,
    );
  }
}
