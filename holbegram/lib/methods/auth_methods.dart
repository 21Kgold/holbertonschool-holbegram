import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'package:holbegram/models/user.dart';

class AuthMethode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String> login({
    required String email,
    required String password,
    }) async {
      if (email.isEmpty || password.isEmpty) return 'Please fill all the fields';
      try {
        var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        // ignore: unused_local_variable
        var user = result.user;
        return 'success';
      } catch (e) {
        return 'Sign-in error: $e';
      }
    }


  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
    }) async {
      if (email.isEmpty || password.isEmpty || username.isEmpty) return 'Please fill all the fields';
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;

        Users users = Users(
          email: email,
          username: username,
          uid: user!.uid,
          bio: '',
          photoUrl: '',
          followers: [],
          following: [],
          posts: [],
          saved: [],
          searchKey: '',
        );

        await _firestore.collection('users').doc(user.uid).set(users.toJson());
        return 'success';
        } catch (e) {
          return 'Sign-in error: $e';
        }
    }


  Future<Users?> getUserDetails() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userData = await _firestore.collection('users').doc(user.uid).get();
        return Users.fromSnap(userData);
      }
      return null;
    } catch (e) {
      // print('Sign-in error: $e');
      return null;
    }
  }
}
