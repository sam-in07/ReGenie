import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:regenie/core/firebase/firebase_service.dart';
import 'package:dartz/dartz.dart';
import 'package:regenie/domain/entities/user.dart';
import 'package:regenie/core/error/failures.dart';
import 'package:regenie/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepository {
  final FirebaseService firebase;

  UserRepoImpl(this.firebase);

  // --- 1. EMAIL LOGIN ---
  @override
  Future<Either<Failure, UserEntity>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await firebase.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;

      if (user == null) return Left(AuthFailure('No user found.'));
      // Optional: Check for email verification
      // if (!user.emailVerified) return Left(AuthFailure('Please verify your email.')); 

      final doc = await firebase.firestore.collection('users').doc(user.uid).get();
      return Right(UserEntity(
        id: user.uid,
        name: doc['name'] ?? user.displayName ?? '',
        email: user.email ?? '',
        points: doc['points'] ?? 0,
      ));
    } on fa.FirebaseAuthException catch (e) {
      return Left(AuthFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // --- 2. EMAIL REGISTRATION ---
  @override
  Future<Either<Failure, UserEntity>> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final cred = await firebase.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;

      if (user == null) return Left(AuthFailure('Registration failed.'));
      // Optional: Send verification email
      // await user.sendEmailVerification(); 

      // Save user info to Firestore
      await firebase.firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': user.email,
        'points': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return Right(UserEntity(id: user.uid, name: name, email: user.email ?? '', points: 0));
    } on fa.FirebaseAuthException catch (e) {
      return Left(AuthFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // --- 3. GOOGLE SIGN-IN ---
  // Note: This method should be defined in your UserRepository interface (user_repo.dart)
  // Future<Either<Failure, UserEntity>> signInWithGoogle() async {
  //   try {
  //     final googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) return Left(AuthFailure('Google sign-in aborted by user.'));
  //
  //     final googleAuth = await googleUser.authentication;
  //     final credential = fa.GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     final userCred = await firebase.auth.signInWithCredential(credential);
  //     final user = userCred.user;
  //     if (user == null) return Left(AuthFailure('Google sign-in failed.'));
  //
  //     final docRef = firebase.firestore.collection('users').doc(user.uid);
  //     final doc = await docRef.get();
  //
  //     // Create Firestore entry if the user is signing in for the first time
  //     if (!doc.exists) {
  //       await docRef.set({
  //         'name': user.displayName ?? '',
  //         'email': user.email ?? '',
  //         'points': 0,
  //         'createdAt': FieldValue.serverTimestamp(),
  //       });
  //     }
  //
  //     // Return the new UserEntity
  //     return Right(UserEntity(
  //       id: user.uid,
  //       name: user.displayName ?? '',
  //       email: user.email ?? '',
  //       points: doc.exists ? doc['points'] ?? 0 : 0, // Use existing points if doc exists
  //     ));
  //   } on fa.FirebaseAuthException catch (e) {
  //     return Left(AuthFailure(_mapFirebaseError(e)));
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }

  // --- 4. GET CURRENT USER ---
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = firebase.auth.currentUser;
      if (user == null) return Left(AuthFailure("No user logged in"));

      final userDoc = await firebase.firestore.collection('users').doc(user.uid).get();

      final userEntity = UserEntity(
        id: user.uid,
        name: userDoc['name'] ?? user.displayName ?? '',
        email: user.email ?? '',
        points: userDoc['points'] ?? 0,
      );
      return Right(userEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // --- 5. LOGOUT ---
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Must sign out from Google if user signed in via Google

     // await GoogleSignIn().signOut();
      await firebase.auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // --- Firebase Error Mapping Helper ---
  String _mapFirebaseError(fa.FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'User account disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'The password must be at least 6 characters.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }
}