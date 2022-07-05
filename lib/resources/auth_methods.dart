import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    String? username,
    String? email,
    String? password,
    String? bio,
    Uint8List? file,
  }) async {
    var res = "error occured";

    if (username!.isNotEmpty &&
        email!.isNotEmpty &&
        password!.isNotEmpty &&
        bio!.isNotEmpty) {
      try {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(credential.user!.uid);

        String photoURL = await StrorageMethods()
            .UploadToStorage('profilePics', file!, false);

        _firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoURL': photoURL
        });
        res = 'success';
      } on FirebaseException catch (error) {
        if (error.code == 'invalid-error') {
          res = 'this email is badly formated';
        } else if (error.code == 'weak-password') {
          res = 'your password should be at least 6 charachters';
        }
      }
    }
    return res;
  }

  Future<String> loginUser({required String email,required String password}) async {
    var res = 'error';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please, fill all the fields';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
