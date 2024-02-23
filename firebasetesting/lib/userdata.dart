import 'package:firebase_auth/firebase_auth.dart';

class UserData{
  final String email;
  final String uid;
  final String username;
  final String bio;

  const UserData({
    required this.email,
    required this.uid,
    required this.username,
    required this.bio,
});
  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "bio": bio,
  };
}