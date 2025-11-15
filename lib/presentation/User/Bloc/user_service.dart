import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

  DocumentReference? get userDocumentRef {
    final currentUid = uid;
    if (currentUid == null) return null;
    return _firestore.collection('users').doc(currentUid);
  }

  Future<void> initializeNewUser(String name, String email) async {
    final userRef = userDocumentRef;
    if (userRef == null) return;

    final Map<String, dynamic> defaultUserData = {
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'points': 1000,
      'level': 1,
      'rank': 11,
      'challengesCompleted': 0,
    };

    await userRef.set(defaultUserData, SetOptions(merge: true));
  }
}
