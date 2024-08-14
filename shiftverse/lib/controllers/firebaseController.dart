import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:intl/intl.dart';
import 'package:shiftverse/models/sales.dart';
import 'package:shiftverse/models/user.dart';

class FirebaseController extends ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

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
  Future<String?> signUp(
      {required String email,
      required String password,
      required String fullNames,
      required String jumuiya}) async {
    String? errorCode;
    try {
      //create a user with email and password
      //we use await to ensure that the method creates and
      //signs in the user so as to send the verification email
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //send email verification
      sendEmailVerification(userCredential);

      //creating user entry in cloud firestore
      //create user object
      Member member = Member(
        userId: userCredential.user?.uid,
        fullNames: fullNames,
        email: email,
        jumuiya: jumuiya,
      );

      //call the method to create user entry in the database
      createUserEntry(
        member: member,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorCode = 'email-already-in-use';
      } else if (e.code == 'weak-password') {
        errorCode = 'weak-password';
      } else if (e.code == 'invalid-email') {
        errorCode = 'invalid-email';
        print(errorCode);
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
  Future<String?> resetPassword(String email) async {
    String? resetPasswordErrorCode;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        resetPasswordErrorCode = e.code;
      }
    }
    return resetPasswordErrorCode;
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

  // Create an user entry in the database
  void createUserEntry({required Member member}) {
    //create a reference to the collection
    final docRef = db.collection('Users').withConverter(
        //the fromFirestore method transforms data from firestore to our custom object
        fromFirestore: (doc, _) => Member.fromFirestore(doc, _),
        //the toFirestore method transforms our custom object to firestore data(map)
        toFirestore: (Member member, _) => member.toFirestore());
    docRef.doc(member.userId).set(member);
  }

  //Create a sale entry in the database
  void createSaleEntry(
      {required String amountSold,
      required String pamphletsLeft,
      required DateTime saleDate}) {
    //create a reference to the collection
    final colRef = db.collection('Sales').withConverter(
        //the fromFirestore method transforms data from firestore to our custom object
        fromFirestore: (doc, _) => Sale.fromFirestore(doc, _),
        //the toFirestore method transforms our custom object to firestore data(map)
        toFirestore: (Sale sale, _) => sale.toFirestore());
    colRef.add(Sale(
      uid: user?.uid,
      saleAmount: double.parse(amountSold),
      pamphletsLeft: double.parse(pamphletsLeft),
      saleDate: saleDate,
    ));
  }

  Stream<QuerySnapshot<Sale>> getSaleRecords() {
    //create a reference to the collection
    final colRef = db.collection('Sales').withConverter(
          fromFirestore: (doc, _) => Sale.fromFirestore(doc, _),
          toFirestore: (Sale sale, _) => sale.toFirestore(),
        );

    //return a stream which listens to the documents in the sales collection
    return colRef.orderBy('saleDate', descending: true).snapshots();
  }

  Future<DocumentSnapshot<Member>>getUserRecord(){

    final colRef = db.collection('Users').withConverter(
      fromFirestore: (doc,_)=>Member.fromFirestore(doc,_), 
      toFirestore: (Member member,_)=>member.toFirestore(),
    );
    // ignore: unnecessary_string_interpolations
    return colRef.doc("${user!.uid}").get();
  }

  //Stream<QuerySnapshot<Sale>>
  Stream<QuerySnapshot<Sale>> getMonthlySaleRecords() {
    //create a reference to the collection
    final colRef = db.collection('Sales').withConverter(
          fromFirestore: (doc, _) => Sale.fromFirestore(doc, _),
          toFirestore: (Sale sale, _) => sale.toFirestore(),
        );

    //obtain the current month in string format
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 1);

    //return a stream containing sale records which are for the current month

    return colRef
        .orderBy('saleDate', descending: true)
        .where('saleDate', isGreaterThanOrEqualTo: startOfMonth)
        .where('saleDate', isLessThan: endOfMonth)
        .snapshots();
  }
}
