part of 'detail_topic_cubit.dart';

class DetailTopicState extends Equatable {
  const DetailTopicState(
      {required this.topic,
      this.statusType = StatusType.init,
      this.photos = const [],
      this.photosOrderBy = TopicPhotosOrderBy.latest});
  final StatusType statusType;
  final List<Photo> photos;
  final Topic topic;
  final TopicPhotosOrderBy photosOrderBy;

  @override
  List<Object> get props => [statusType, photos, photosOrderBy];

  DetailTopicState copyWith(
      {StatusType? statusType,
      List<Photo>? photos,
      Topic? topic,
      TopicPhotosOrderBy? photosOrderBy}) {
    return DetailTopicState(
        statusType: statusType ?? this.statusType,
        photos: photos ?? this.photos,
        topic: topic ?? this.topic,
        photosOrderBy: photosOrderBy ?? this.photosOrderBy);
  }
}
