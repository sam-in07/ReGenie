import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:regenie/domain/entities/user.dart';
import 'package:regenie/domain/repositories/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial());

  Future<void> login(String email, String password) async {
    emit(UserLoading());
    final result = await userRepository.loginUser(email: email, password: password);

    result.fold(
          (failure) => emit(UserError(failure.message ?? 'An unknown error occurred')),
          (user) => emit(UserLoggedIn(user)),
    );

  }

  // Future<void> signInWithGoogle() async {
  //   emit(UserLoading());
  //   final result = await userRepository.signInWithGoogle();
  //   result.fold(
  //         (failure) => emit(UserError(failure.message)),
  //         (user) => emit(UserLoggedIn(user)),
  //   );
  // }





  Future<void> register(String email, String password, String name) async {
    emit(UserLoading());
    final result = await userRepository.registerUser(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
          (failure) => emit(UserError(failure.message ?? 'An unknown error occurred')),
          (user) => emit(UserLoggedIn(user)),
    );

  }

  Future<void> logout() async {
    emit(UserLoading());
    try {
      await userRepository.logout();
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }


  Future<void> getCurrentUser() async {
    emit(UserLoading());
    final result = await userRepository.getCurrentUser();
    result.fold(
          (failure) => emit(UserError(failure.message ?? 'An unknown error occurred')),
          (user) => emit(UserLoggedIn(user)),
    );

  }
}
