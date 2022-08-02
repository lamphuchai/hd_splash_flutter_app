import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_photo_state.dart';

class DetailPhotoCubit extends Cubit<DetailPhotoState> {
  DetailPhotoCubit() : super(DetailPhotoInitial());
}
