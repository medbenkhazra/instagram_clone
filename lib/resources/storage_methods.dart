import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StrorageMethods {
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseStorage firebase_storage= FirebaseStorage.instance;

  Future<String> UploadToStorage(String childName,Uint8List file,bool isPost) async {

    Reference ref= firebase_storage.ref().child('UserPic').child(_auth.currentUser!.uid);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snapshot=await uploadTask;
    String downloadURL=await snapshot.ref.getDownloadURL();

    return downloadURL;
  }
  
}