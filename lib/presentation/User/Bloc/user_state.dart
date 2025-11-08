part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoggedIn extends UserState {
  final UserEntity user;

  UserLoggedIn(this.user);

  @override
  List<Object?> get props => [user];
}

class UserRegistered extends UserState {
  final UserEntity user;

  UserRegistered(this.user);

  @override
  List<Object?> get props => [user];
}

class UserLoggedOut extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}
