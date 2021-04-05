import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Stream<UserModel> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<UserModel> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<UserModel> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  // Future<String> currentUser() async {
  //   final user = _firebaseAuth.currentUser;
  //   return _userFromFirebase(user).uid;
  // }

  currentUser() {
    final User user = _firebaseAuth.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final authResult = (await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password));
      return _userFromFirebase(authResult.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
      } else {
        print("Something Went Wrong.");
      }
      return null;
    }
  }

  Future<String> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firebaseAuth.currentUser.updateProfile(displayName: name);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

void updateUserName(User firebaseUser, String name) {
  firebaseUser
      .updateProfile(displayName: name)
      .then((value) => print("Name Updated Sucessfully"));
}
