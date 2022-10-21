import 'package:perfegged/dataclasses/preset.dart';

class Recipe {
  final presetList = <Preset>[];

  Recipe(Preset preset) {
    presetList.add(preset);
  }

  addPreset(Preset preset) {
    presetList.add(preset);
  }

  removePreset(Preset preset) {
    presetList.remove(preset);
  }

}