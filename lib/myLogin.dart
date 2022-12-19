import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:perfegged/dataclasses/appstate.dart';
import 'package:perfegged/functional_elements/appbar.dart';
import 'package:provider/provider.dart';
import 'package:perfegged/dataclasses/auth.dart';

import 'dataclasses/preset.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  User? user; // track the authenticated user here
  final db = Auth.fireStoreInstance;

  @override
  void initState() {
    super.initState();
    Auth.firebaseAuth!.authStateChanges().listen((User? user) async {
      Provider.of<AppState>(context, listen: false).setUser = user;
      AppState.fireStoreInstance = db;
      if (mounted) {
        setState(() => this.user = user);
      }
      if (user != null) {
        final ref = db!.collection('users').doc(user.uid).collection('presets').withConverter(
              fromFirestore: Preset.fromFirestore,
              toFirestore: (Preset preset, options) => preset.toFirestore(),
            );
        final snapshot = await ref.get();
        if (snapshot.size == 0) {
          AppState.init();
          await AppState.initializingDone;
          List<Preset>? presets = AppState.list; //list that holds preset-objects
          for (var preset in presets!) {
            await ref.doc(preset.id.toString()).set(preset).onError((e, _) => print("Error writing document: $e"));
          }
        } else {
          AppState.list = [];
          final queryList = snapshot.docs;
          for (var element in queryList) {
            AppState.list!.add(Preset(eggWeight: element.data().eggWeight, envTemp: element.data().envTemp, yolkTemp: element.data().yolkTemp));
            AppState.list!.last.id = int.parse(element.id);
          }
        }
      } else {
        AppState.init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Login'),
      body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SignInButtonBuilder(
                  text: 'Sign in anonymously',
                  icon: Icons.account_circle,
                  onPressed: () async => loginAnonymously(),
                  backgroundColor: Colors.blueGrey
                ),
                const SizedBox(height: 16),
                SignInButton(
                  Buttons.Google, 
                  onPressed: () => loginWithGoogle()
                ),
                Container(child: userInfo()),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red), 
                  onPressed: user != null ? () => logout() : null, 
                  child: const Text('Sign out')
                )
              ],
            ),
          )
        ),
    );
  }

  Widget userInfo() {
    if (user == null) {
      return const Text('Sign in for full functionality');
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
    return Auth.firebaseAuth!.signInAnonymously();
  }

  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await Auth.firebaseAuth!.signInWithCredential(credential);
  }


 
  logout() => Auth.firebaseAuth!.signOut();
}
