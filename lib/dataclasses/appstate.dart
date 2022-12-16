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
    print(presetID);
    return presetID++;
  }

  //holds the current Preset object to work with
  static Preset? currPreset;
  Preset? get getCurrPreset => currPreset;
  setCurrPreset(Preset? preset) {
    currPreset = preset;
    notifyListeners();
  }

  static Future<List<Preset>>? _presets;
  Future<List<Preset>>? get getPresets => _presets;
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
    //initilaze values
    //print("initializing AppState");
    if (User == null) {
    } else {}
    _presets ??= parsePresetJson('assets/data/presets.json');
    initPreset();
    if (_fireStoreInstance != null) {
      getDBPresets();
    }
  }

  void initPreset() async {
    list ??= await _presets;
    currPreset ??= list!.last;
    //print(_currPreset.toString());
  }

  void getDBPresets() async {
    /*
    DocumentSnapshot doc = await _fireStoreInstance!.collection('users').doc(_user!.uid).get();
    Map<String, dynamic>? dict = doc.data() as Map<String, dynamic>?;
    print(dict);
    */

    await _fireStoreInstance!.collection("users").doc(_user!.uid).get().then((event) {
      print("${event.data()}");
    });
  }
}
