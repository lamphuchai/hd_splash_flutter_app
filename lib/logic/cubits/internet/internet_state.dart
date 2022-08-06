part of 'internet_cubit.dart';

enum InternetStatus { init, internet, none }

class InternetState extends Equatable {
  const InternetState({this.status = InternetStatus.init});
  final InternetStatus status;
  @override
  List<Object> get props => [status];
}
