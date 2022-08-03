import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:unsplash_dart/unsplash_dart.dart';

part 'detail_photo_state.dart';

class DetailPhotoCubit extends Cubit<DetailPhotoState> {
  DetailPhotoCubit({required Photo photo, required Photos photos})
      : _photos = photos,
        super(DetailPhotoState(photo: photo));
  final Photos _photos;
  Future<void> loadingExifPhoto() async {
    try {
      emit(state.copyWith(status: StatusType.loading));
      final photo = await _photos.photoById(id: state.photo.id);
      emit(state.copyWith(status: StatusType.loaded, dataPhoto: {
        "tags": photo.tags,
        "exif": photo.exif,
        "views": photo.views,
        "downloads": photo.downloads
      }));
    } catch (error) {
      print(error);
      emit(state.copyWith(status: StatusType.err));
    }
  }
}
