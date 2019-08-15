import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  FirebaseUser loggedInUser;
  DocumentReference selectedVehicle;

  AppState(FirebaseUser firebaseUser, DocumentReference documentReference){
    loggedInUser = firebaseUser;
    selectedVehicle = documentReference;
  }
}