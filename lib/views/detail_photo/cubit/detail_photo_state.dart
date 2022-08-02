part of 'detail_photo_cubit.dart';

enum PhotoStatus { init, loading, loaded, err }

class DetailPhotoState extends Equatable {
  const DetailPhotoState(
      {required this.photo,
      this.status = PhotoStatus.init,
      this.dataPhoto =const {}});
  final Photo photo;
  final PhotoStatus status;
  final Map<String,dynamic> dataPhoto;
  @override
  List<Object> get props => [photo, status, dataPhoto];

  DetailPhotoState copyWith({Photo? photo, PhotoStatus? status, Map<String,dynamic>? dataPhoto}) {
    return DetailPhotoState(
        photo: photo ?? this.photo,
        status: status ?? this.status,
        dataPhoto: dataPhoto ?? this.dataPhoto);
  }
}
