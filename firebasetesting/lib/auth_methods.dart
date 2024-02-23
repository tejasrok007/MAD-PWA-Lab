import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userdata.dart';
class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> registerUser({
    required String email,
    required String password,
    required String username,
    required String bio,
})async{
    String resp = "Some error occurred";
    try{
        if(email.isNotEmpty ||
            password.isNotEmpty ||
            username.isNotEmpty ||
            bio.isNotEmpty)
        {
          UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
          UserData userData = UserData(email: email, uid: cred.user!.uid, username: username, bio: bio);
          await _firestore.collection('users').doc(cred.user!.uid).set(userData.toJson(),);
          resp = "success";
        }

    }
    catch(err){
      resp = err.toString();
    }
    return resp;
  }
  Future<String> loginUser({
    required String email,
    required String password,
})async{
    String res = "Some error occurred";
    try{
        if(email.isNotEmpty || password.isNotEmpty){
          await _auth.signInWithEmailAndPassword(email: email, password: password);
        }
        res = "success";
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
}