import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> with HydratedMixin {
  SearchCubit() : super(const SearchState(query: "", listHistory: ["china"]));

  @override
  SearchState? fromJson(Map<String, dynamic> json) {
    return state.copyWith(
        listHistory: (json["listHistory"] as List)
            .map((history) => history.toString())
            .toList());
  }

  void onChangeQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void onSaveHistory() {
    emit(state.copyWith(listHistory: [...state.listHistory, state.query]));
  }

  void deleteAllHistory() {
    emit(state.copyWith(listHistory: []));
  }

  @override
  Map<String, dynamic>? toJson(SearchState state) {
    return {"listHistory": state.listHistory};
  }
}
