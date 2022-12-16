import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:perfegged/dataclasses/appstate.dart';
import 'package:perfegged/functional_elements/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dataclasses/preset.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  User? user; // track the authenticated user here

  final _emailInput = TextEditingController(text: 'example@mail.com');
  final _passInput = TextEditingController(text: 'password');
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() => this.user = user);
      AppState().setUser = user;
      AppState().setFireStoreInstance = db;

      if (user != null) {
        final dbuser = <String, dynamic>{
          "uid": user.uid,
        };
        //db.collection('users').add(dbuser).then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
        db.collection('users').doc(user.uid).set(dbuser).onError((e, _) => print("Error writing document: $e"));
        ;
        List<Preset>? presets = AppState.list;
        /*
CollectionReference users = Appstate._firebaseInstance
        */
        for (var preset in presets!) {
          db
              .collection('users')
              .doc(user.uid)
              .collection('presets')
              .withConverter(
                fromFirestore: Preset.fromFirestore,
                toFirestore: (Preset preset, options) => preset.toFirestore(),
              )
              .doc(preset.id.toString())
              .set(preset)
              .onError((e, _) => print("Error writing document: $e"));
        }
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Login'),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SignInButtonBuilder(
              text: 'Sign in anonymously', icon: Icons.account_circle, onPressed: () async => loginAnonymously(), backgroundColor: Colors.blueGrey),
          SignInButton(Buttons.Email, onPressed: () => loginWithEmail(_emailInput.text, _passInput.text)),
          SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(width: 150, child: TextField(controller: _emailInput, decoration: InputDecoration(hintText: 'Email'))),
            SizedBox(width: 150, child: TextField(controller: _passInput, obscureText: true, decoration: InputDecoration(hintText: 'Password'))),
          ]),
          SizedBox(height: 16),
          SignInButton(Buttons.Google, onPressed: () => loginWithGoogle()),
          Container(child: userInfo()),
          ElevatedButton(child: Text('Sign out'), style: ElevatedButton.styleFrom(primary: Colors.red), onPressed: user != null ? () => logout() : null)
        ],
      )),
    );
  }

  Widget userInfo() {
    if (user == null)
      return Text('Not signed in.');
    else {
      User user = this.user!;
      if (user.isAnonymous) {
        return Text('Anonymous sign in: ${user.uid}.');
      }
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        if (user.photoURL != null) Image.network(user.photoURL!, width: 50),
        Text('Signed in as ${user.displayName != null ? user.displayName! + ', ' : ''}${user.email}.')
      ]);
    }
  }

  Future<UserCredential> loginAnonymously() {
    return FirebaseAuth.instance.signInAnonymously();
  }

  Future<UserCredential?> loginWithEmail(String email, String pass) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return Future.value(null);
    }
  }

  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  logout() => FirebaseAuth.instance.signOut();
}
