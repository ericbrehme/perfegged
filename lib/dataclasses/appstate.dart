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
  static User? _user;
  User? get getUser => _user;
  set setUser(User? user) => _user = user;

  //holds currently active CountDownController object
  static CountDownController? _countDownController;
  CountDownController? get getcountDownController => _countDownController;
  set setCountDownController(CountDownController? countDownController) => _countDownController = countDownController;

  //FirebaseFirestore
  static FirebaseFirestore? _fireStoreInstance;
  FirebaseFirestore? get getFireStoreInstance => _fireStoreInstance;
  set setFireStoreInstance(FirebaseFirestore? fireStoreInstance) => _fireStoreInstance = fireStoreInstance;

  AppState() {
    if (_user == null) {
      initPreset();
    } else {}
    if (_fireStoreInstance != null) {
      getDBPresets();
    }
  }

  void initPreset() async {
    list ??= await parsePresetJson('assets/data/presets.json');
    currPreset ??= list!.last;
    //print(_currPreset.toString());
  }

  void getDBPresets() async {
    await _fireStoreInstance!.collection("users").doc(_user!.uid).get().then((event) {
      print("${event.data()}");
    });
  }
}
