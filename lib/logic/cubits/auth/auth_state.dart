// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingAuth extends AuthState {}

class Authenticated extends AuthState {
  Authenticated({required this.user,this.collections =const []});
  final User user;
  final List<Collection> collections;
  @override
  List<Object> get props => [user,collections];
}

class Unauthenticated extends AuthState {}
