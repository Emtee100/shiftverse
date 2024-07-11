import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseContorller extends ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  //String? errorCode;

  //Sign in with email and password
  void signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
      } else if (e.code == 'invalid-email') {
        print('Email is not valid, please enter a valid email address');
      } else if (e.code == 'user-not-found') {
        print('User is not found, please sign up first');
      }
    } catch (e) {
      print(e);
    }
  }

  //Sign up with email and password
  Future<String?> signUp(String email, String password) async {
    String? errorCode;
    try {
      //create a user with email and password
      //we use await to ensure that the method creates and
      //signs in the user so as to send the verification email
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //send email verification
      sendEmailVerification(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorCode = 'email-already-in-use';
      } else if (e.code == 'weak-password') {
        errorCode = 'weak-password';
      } else if (e.code == 'invalid-email') {
        errorCode = 'invalid-email';
      }
    }
    return errorCode;
  }

  //sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign out
  void signOut() {
    firebaseAuth.signOut();
  }

  //Reset password
  Future <String?> resetPassword(String email) async{
    String? resetPassworderrorCode;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/invalid-email') {
        resetPassworderrorCode = 'invalid-email';
        print(resetPassworderrorCode);
      } else if (e.code == 'auth/user-not-found') {
        resetPassworderrorCode = 'user-not-found';
        print(resetPassworderrorCode);
      }
    }
    return resetPassworderrorCode;
  }

  void sendEmailVerification(UserCredential userCredential) {
    userCredential.user?.sendEmailVerification();
  }

  //Change password
  // void changePassword(String password){
  //   firebaseAuth.currentUser.updatePassword(password);
  // }

  //Change email
  // void changeEmail(String email){
  //   firebaseAuth.currentUser?.verifyBeforeUpdateEmail(email);
  // }
}
