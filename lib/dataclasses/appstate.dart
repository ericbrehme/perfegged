import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:perfegged/dataclasses/preset.dart';
import 'package:perfegged/functional_elements/countdown_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfegged/reusable_functions/jsonparser.dart';

class AppState extends ChangeNotifier {
  //id counter for presets
  static int presetID = 0;
  int get getNewPresetID {
    //print(presetID);
    return presetID++;
  }

  //holds the current Preset object to work with
  static Preset? currPreset;
  Preset? get getCurrPreset => currPreset;
  setCurrPreset(Preset? preset) {
    currPreset = preset;
    notifyListeners();
  }

  static List<Preset>? list;
  List<Preset>? getList() {
    return list;
  }

  //holds the current User
  static User? user;
  User? get getUser => user;
  set setUser(User? user) => user = user;

  //holds currently active CountDownController object
  static CountDownController? countDownController;
  CountDownController? get getcountDownController => countDownController;
  set setCountDownController(CountDownController? cdController) => countDownController = cdController;

  //FirebaseFirestore
  static FirebaseFirestore? fireStoreInstance;
  FirebaseFirestore? get getFireStoreInstance => fireStoreInstance;
  set setFireStoreInstance(FirebaseFirestore? fSInstance) => fireStoreInstance = fSInstance;

/*   AppState() {
    //redundant?
    if (user == null) {
      //print(user!.uid);
      //initPreset();
    } else {
      if (fireStoreInstance != null) {
        getDBPresets();
      }
    }
  } */

  notify() {
    notifyListeners();
  }

  static Future? _initDone;
  static Future? get initializingDone => _initDone;

  static init() {
    _initDone = _initPreset();
  }

  static Future _initPreset() async {
    list ??= await parsePresetJson('assets/data/presets.json');
    currPreset ??= list!.last;
  }

  void getDBPresets() async {
    await fireStoreInstance!.collection("users").doc(user!.uid).get().then((event) {
      print("${event.data()}");
    });
  }
}
