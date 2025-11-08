import 'package:firebase_auth/firebase_auth.dart';
import 'package:regenie/core/firebase/firebase_service.dart';


class UserRepoImpl implements UserRepository {
  final FirebaseService firebase;

  UserRepoImpl(this.firebase);

  @override
  Future<User?> login(String email, String password) async {
    final credential = await firebase.auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  @override
  Future<User?> register(String email, String password) async {
    final credential = await firebase.auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }
}
