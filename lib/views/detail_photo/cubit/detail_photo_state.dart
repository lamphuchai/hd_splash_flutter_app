part of 'detail_photo_cubit.dart';

class DetailPhotoState extends Equatable {
  const DetailPhotoState({
    required this.photo,
    this.status = StatusType.init,
  });
  final Photo photo;
  final StatusType status;
  @override
  List<Object> get props => [photo, status];

  DetailPhotoState copyWith({Photo? photo, StatusType? status}) {
    return DetailPhotoState(
      photo: photo ?? this.photo,
      status: status ?? this.status,
    );
  }
}
