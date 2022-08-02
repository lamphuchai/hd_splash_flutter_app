import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

part 'detail_collection_state.dart';

class DetailCollectionCubit extends Cubit<DetailCollectionState> {
  DetailCollectionCubit(
      {required Collection collection, required Collections collections})
      : _collections = collections,
        super(DetailCollectionState(collection: collection));

  final Collections _collections;

  Future<void> loadingPhotos() async {
    try {
      emit(state.copyWith(statusType: StatusType.loading));
      final photos =
          await _collections.photosInCollectionById(id: state.collection.id);
      emit(state.copyWith(photos: photos, statusType: StatusType.loaded));
    } catch (error) {
      emit(state.copyWith(statusType: StatusType.error));
    }
  }
}
