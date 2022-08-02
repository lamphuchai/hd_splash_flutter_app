part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.currentIndex = 0});
  final int currentIndex;

  @override
  List<Object> get props => [currentIndex];
}
