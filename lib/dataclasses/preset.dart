import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfegged/dataclasses/appstate.dart';
import 'egg_sizes.dart';

class Preset {
  int id = 0; //
  int eggWeight = 0; // weight of the egg (may need to be calculated if not given directly by user)
  int eggCircumference = 0; // Circumference of the egg (only used when user chooses to)
  int envTemp = 0; // temperature in °C of the egg
  int yolkTemp = 0; // desired temperature of yolk after cooking (yolk consistency depends on this)
  int pressure = 1013; //Pressure of surrounding air in hPa
  int elevation = 0; //elevation in meters above sea level
  int waterTemp = 100;
  int minutes = 0;
  int seconds = 0;

  Preset({required this.eggWeight, required this.envTemp, required this.yolkTemp, this.pressure = 1013, this.elevation = 0}) {
    // calculate cooking time from weight (most exact)
    id = AppState().getNewPresetID;
    waterTemp = calculateWaterTemp().toInt();
    calcTime();
  }

  Preset.fromCircumference({required int eggCircumference, required int envTemp, required int yolkTemp}) {
    // calculate cooking time from circumference (rough)
  }

  Preset.fromSize({required String eggSize, required int envTemp, required int yolkTemp}) {
    // calculate cooking time from weight which is the average of given standart size (rough)
  }

  Preset.fromJson(Map<String, dynamic> json) {
    id = AppState().getNewPresetID;
    eggWeight = json['eggWeight'];
    envTemp = json['envTemp'];
    yolkTemp = json['yolkTemp'];
    calcTime();
    // print(Eggsizes.egg_size_eu['XS']);
  }

  calcTime() {
    num time = calculateTimeWeight();
    minutes = time.toInt();
    seconds = ((time - minutes) * 60).toInt();
    print("time(mm:ss)  ${minutes.toString()}:${seconds.toString()}");
  }

  String calcEggSize() {
    if (eggWeight < Eggsizes.eggSizeEuMax['XS']!) {
      return 'XS';
    } else if (eggWeight < Eggsizes.eggSizeEuMax['S']!) {
      return 'S';
    } else if (eggWeight < Eggsizes.eggSizeEuMax['M']!) {
      return 'M';
    } else if (eggWeight < Eggsizes.eggSizeEuMax['L']!) {
      return 'L';
    } else if (eggWeight < Eggsizes.eggSizeEuMax['XL']!) {
      return 'XL';
    } else {
      return 'XXL';
    }
  }

  double calculateTimeSize() {
    double time;
    time = (0.0152 * math.pow(eggCircumference, 2)) * math.log(2 * (envTemp - waterTemp) / (yolkTemp - waterTemp));
    print("time  ${time.toString()}");
    return time;
  }

  double calculateTimeWeight() {
    double time;
    time = (0.451 * math.pow(eggWeight, 2 / 3)) * math.log(0.76 * (envTemp - waterTemp) / (yolkTemp - waterTemp));
    print("time  ${time.toString()}");
    return time;
  }

  double calculateWaterTemp() {
    //returns boiling temperature of water in C° for a given pressure
    //num pressureAtElevation = pressure * (math.pow((1 - 6.5 * elevation) / 288150, 5.255));
    //print(pressureAtElevation);
    double temp = 1730.63 / (8.07131 - (math.log(pressure / 1.33322387415) / math.ln10)) - 233.426;
    print("temperature  ${temp.toString()}");
    return temp;
  }

  Map<String, Object?> toFirestore() {
    return {
      "eggWeight": eggWeight,
      "yolkTemp": yolkTemp,
      "envTemp": envTemp,
    };
  }

  factory Preset.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Preset(eggWeight: data?['eggWeight'], envTemp: data?['envTemp'], yolkTemp: data?['yolkTemp']);
  }
}

String calcYolkConsistency(yolkTemp) {
  if (yolkTemp < 64) {
    return 'Liquid';
  } else if (yolkTemp < 66) {
    return 'Merely set';
  } else if (yolkTemp < 70) {
    return 'Soft runny';
  } else if (yolkTemp < 80) {
    return 'Waxy';
  } else if (yolkTemp < 90) {
    return 'Firm';
  } else {
    return 'Crumbly';
  }
}

double calculateWaterTemp(num pressure) {
  //returns boiling temperature of water in C° for a given pressure
  //num pressureAtElevation = pressure * (math.pow((1 - 6.5 * elevation) / 288150, 5.255));
  //print(pressureAtElevation);
  double temp = 1730.63 / (8.07131 - (math.log(pressure / 1.33322387415) / math.ln10)) - 233.426;
  print("temperature  ${temp.toString()}");
  return temp;
}
