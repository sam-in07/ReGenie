// lib/data/repositories/user_repo_impl.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:regenie/core/firebase/firebase_service.dart';
import 'package:regenie/domain/entities/user.dart';
import 'package:regenie/domain/repositories/user_repo.dart';
import 'package:regenie/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class UserRepoImpl implements UserRepository {
  final FirebaseService firebase;

  UserRepoImpl(this.firebase);

  @override
  Future<Either<Failure, UserEntity>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebase.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return Left(AuthFailure("Login failed — user is null."));
      }

      // Fetch extra user data from Firestore if needed
      final userDoc =
      await firebase.firestore.collection('users').doc(user.uid).get();

      final userEntity = UserEntity(
        id: user.uid,
        name: userDoc['name'] ?? '',
        email: user.email ?? '',
        points: userDoc['points'] ?? 0,
      );

      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Firebase Auth error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await firebase.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return Left(AuthFailure("Registration failed — user is null."));
      }

      // Save user info to Firestore
      await firebase.firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'points': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final userEntity =
      UserEntity(id: user.uid, name: name, email: email, points: 0);

      return Right(userEntity);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Firebase Auth error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    final user = firebase.auth.currentUser;
    if (user == null) return Left(AuthFailure("No user logged in"));

    final userDoc =
    await firebase.firestore.collection('users').doc(user.uid).get();

    final userEntity = UserEntity(
      id: user.uid,
      name: userDoc['name'] ?? '',
      email: user.email ?? '',
      points: userDoc['points'] ?? 0,
    );
    return Right(userEntity);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await firebase.auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
