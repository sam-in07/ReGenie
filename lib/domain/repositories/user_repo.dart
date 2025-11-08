import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> registerUser({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, UserEntity>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, void>> logout();
}
