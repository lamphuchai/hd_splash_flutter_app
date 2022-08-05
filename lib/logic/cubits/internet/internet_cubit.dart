import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(const InternetState()) {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(const InternetState(isConnection: false));
      } else {
        emit(const InternetState(isConnection: true));
      }
    });
  }

  late StreamSubscription _streamSubscription;
  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
