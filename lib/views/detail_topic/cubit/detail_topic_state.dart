part of 'detail_topic_cubit.dart';

class DetailTopicState extends Equatable {
  const DetailTopicState(
      {required this.topic,
      this.statusType = StatusType.init,
      this.photos = const [],
      this.currentIndex = 1});
  final StatusType statusType;
  final List<Photo> photos;
  final Topic topic;
  final int currentIndex;

  @override
  List<Object> get props => [statusType, photos, currentIndex];

  DetailTopicState copyWith(
      {StatusType? statusType,
      List<Photo>? photos,
      Topic? topic,
      int? currentIndex}) {
    return DetailTopicState(
        statusType: statusType ?? this.statusType,
        photos: photos ?? this.photos,
        topic: topic ?? this.topic,
        currentIndex: currentIndex ?? this.currentIndex);
  }
}
