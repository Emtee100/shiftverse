import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseContorller extends ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

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
  void signUp(String email, String password) async{
    try {
      //create a user with email and password
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //send email verification
       userCredential.user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Email is already in use, please sign in');
      } else if (e.code == 'weak-password') {
        print('Password is too weak, please enter a stronger password');
      } else if (e.code == 'invalid-email') {
        print('Email is not valid, please enter a valid email address');
      }
    }
  }

  //Sign out
  void signOut() {
    firebaseAuth.signOut();
  }

  //Reset password
  void resetPassword(String email) {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // void sendEmailVerification() async {
  //   firebaseAuth.currentUser?.sendEmailVerification();
  // }

  //Change password
  // void changePassword(String password){
  //   firebaseAuth.currentUser.updatePassword(password);
  // }

  //Change email
  // void changeEmail(String email){
  //   firebaseAuth.currentUser?.verifyBeforeUpdateEmail(email);
  // }
}
