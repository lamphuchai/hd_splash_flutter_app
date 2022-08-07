import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'search_state.dart';

class SearchCubit extends HydratedCubit<SearchState> {
  SearchCubit() : super(const SearchState(query: "", listHistory: []));

  void onChangeQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void onSaveHistory() {
    final listHistory = [state.query, ...state.listHistory];
    emit(state.copyWith(listHistory: listHistory.toSet().toList()));
  }

  void deleteAllHistory() {
    emit(state.copyWith(listHistory: []));
  }

  @override
  SearchState? fromJson(Map<String, dynamic> json) {
    final listHistory = (json["listHistory"] as List)
        .map((history) => history.toString())
        .toList();
    return state.copyWith(listHistory: listHistory);
  }

  @override
  Map<String, dynamic>? toJson(SearchState state) {
    return {"listHistory": state.listHistory};
  }
}
