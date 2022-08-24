import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get user => _auth.currentUser;

  static Future<bool> login(String email, String password) async{
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user != null;
  }

  static Future<bool> register(String email, String password) async{
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user != null;
  }

  static Future<void> logout() => _auth.signOut();

  static bool isEmailVerified() => _auth.currentUser!.emailVerified;

  static Future<void> sendVerificationEmail() => _auth.currentUser!.sendEmailVerification();

  static Future<void> updateDisplayName(String name) => _auth.currentUser!.updateDisplayName(name);

  static Future<void> updateDisplayImage(String image) => _auth.currentUser!.updatePhotoURL(image);

  // static Future<void> updateEmail(String newEmail) => _auth.currentUser!.updateEmail(newEmail);

}