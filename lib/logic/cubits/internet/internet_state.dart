part of 'internet_cubit.dart';

class InternetState extends Equatable {
  const InternetState({this.isConnection = true});
  final bool isConnection;
  @override
  List<Object> get props => [isConnection];
}
