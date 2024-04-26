import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'package:holbegram/models/user.dart';

class AuthMethode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({required String email,required String password,}) async {
    
    if (email.isEmpty || password.isEmpty) 'Please fill all the fields';

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.code;
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
      if (email.isEmpty || password.isEmpty || username.isEmpty) 'Please fill all the fields';
  
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

        await _firestore.collection('users').doc(users.uid).set(users.toJson());
        return 'success';
        } catch (e) {
            return 'Sign-in error: $e';
        }
    }
}
