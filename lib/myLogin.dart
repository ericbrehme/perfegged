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

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      AppState.user = user;
      AppState.fireStoreInstance = db;
      setState(() => this.user = user);
      if (user != null) {
/* 
        final dbuser = <String, dynamic>{
          "uid": user.uid,
        };
        //db.collection('users').add(dbuser).then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
        db.collection('users').doc(user.uid).set(dbuser).onError((e, _) => print("Error writing document: $e"));
         */
        //final snapshot = await db.collection(user.uid).get();
        final ref = db.collection('users').doc(user.uid).collection('presets').withConverter(
              fromFirestore: Preset.fromFirestore,
              toFirestore: (Preset preset, options) => preset.toFirestore(),
            );
        final snapshot = await ref.get();
        if (snapshot.size == 0) {
          //Presetlist doesn't exist, store default preset-list to firestore
          List<Preset>? presets = AppState.list; //list that holds preset-objects
          for (var preset in presets!) {
            await ref.doc(preset.id.toString()).set(preset).onError((e, _) => print("Error writing document: $e"));
          }
        } else {
          AppState.list = [];
          final queryList = snapshot.docs; // ??? - returns List<QueryDocumentSnapshot<Preset>>
          // how do i use 'toFirestore' here to fill the list
          queryList.forEach((element) {
            AppState.list!.add(Preset(eggWeight: element.data().eggWeight, envTemp: element.data().envTemp, yolkTemp: element.data().yolkTemp));
            AppState.list!.last.id = int.parse(element.id);
          });
        }
      }
    });
    setState(() {});
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
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(width: 150, child: TextField(controller: _emailInput, decoration: const InputDecoration(hintText: 'Email'))),
            SizedBox(width: 150, child: TextField(controller: _passInput, obscureText: true, decoration: const InputDecoration(hintText: 'Password'))),
          ]),
          const SizedBox(height: 16),
          SignInButton(Buttons.Google, onPressed: () => loginWithGoogle()),
          Container(child: userInfo()),
          ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.red), onPressed: user != null ? () => logout() : null, child: const Text('Sign out'))
        ],
      )),
    );
  }

  Widget userInfo() {
    if (user == null) {
      return const Text('Not signed in.');
    } else {
      User user = this.user!;
      if (user.isAnonymous) {
        return Text('Anonymous sign in: ${user.uid}.');
      }
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        if (user.photoURL != null) Image.network(user.photoURL!, width: 50),
        Text('Signed in as ${user.displayName != null ? '${user.displayName!}, ' : ''}${user.email}.')
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
