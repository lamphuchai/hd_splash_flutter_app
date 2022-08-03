// ignore_for_file: public_member_api_docs, sort_constructors_first



part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    required this.listHistory,
    required this.query,
  });
  final List<String> listHistory;
  final String query;
  @override
  List<Object> get props => [listHistory,query];

  

  SearchState copyWith({
    List<String>? listHistory,
    String? query,
  }) {
    return SearchState(
      listHistory: listHistory ?? this.listHistory,
      query: query ?? this.query,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listHistory': listHistory,
      'query': query,
    };
  }



  @override
  bool get stringify => true;
}
