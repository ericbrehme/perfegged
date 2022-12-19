import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfegged/dataclasses/appstate.dart';

class Auth {
  static FirebaseAuth? firebaseAuth;
  static FirebaseFirestore? fireStoreInstance;
  
  static Future? _initDone;
  static Future? get initializingDone => _initDone;

  static init() {
    _initDone = _initAuth();
  }

  static Future _initAuth() async {
    firebaseAuth = FirebaseAuth.instance;
    fireStoreInstance = FirebaseFirestore.instance;
    AppState.user = firebaseAuth!.currentUser;
    AppState.fireStoreInstance = fireStoreInstance;
  }
}
  
