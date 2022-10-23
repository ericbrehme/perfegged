import 'dart:math';

import 'egg_sizes.dart';
class Preset {
  
  int id = 0;                // 
  int eggWeight = 0;         // weight of the egg (may need to be calculated if not given directly by user)
  int eggCircumference = 0;  // Circumference of the egg (only used when user chooses to)
  int envTemp = 0;           // temperature in °C of the egg
  int yolkTemp = 0;          // desired temperature of yolk after cooking (yolk consistency depends on this)
  int minutes = 0;
  int seconds = 0;

  Preset({ required this.id, required int eggWeight, required int envTemp, required int yolkTemp }) {
    // calculate cooking time from weight (most exact)
    this.eggWeight = eggWeight;
    this.envTemp = envTemp;
    this.yolkTemp = yolkTemp;
    calcTime();
  }

  Preset.fromCircumference({ required int eggCircumference, required int envTemp, required int yolkTemp }) {
    // calculate cooking time from circumference (rough)

  }

  Preset.fromSize({ required String eggSize, required int envTemp, required int yolkTemp }) {
    // calculate cooking time from weight which is the average of given standart size (rough)
  }

  Preset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eggWeight = json['eggWeight'];
    envTemp = json['envTemp'];
    yolkTemp = json['yolkTemp'];
    calcTime();
    // print(Eggsizes.egg_size_eu['XS']);
  }

  calcTime(){
    num time = calculateTimeWeight();
    minutes = time.toInt();
    seconds = ((time - minutes) * 60).toInt();
  }

  String calcEggSize(){
    if( eggWeight < Eggsizes.egg_size_eu_max['XS']!){
      return 'XS';
    } else if (eggWeight < Eggsizes.egg_size_eu_max['S']!) {
      return 'S';
    }
    else if (eggWeight < Eggsizes.egg_size_eu_max['M']!) {
      return 'M';
    }
    else if (eggWeight < Eggsizes.egg_size_eu_max['L']!) {
      return 'L';
    }
    else if (eggWeight < Eggsizes.egg_size_eu_max['XL']!) {
      return 'XL';
    }
    else {
      return 'XXL';
    }
  } 

  String calcYolkConsistency() {
    if (yolkTemp < 64 ) {
      return 'Liquid';
    } else if (yolkTemp < 66) {
      return 'Merely set';
    } else if (yolkTemp < 70) {
      return 'Soft runny';
    } else if (yolkTemp < 80) {
      return 'Waxy';
    } else if (yolkTemp < 90) {
      return 'Firm';
    } else{
      return 'Crumbly';
    }
  }


  double calculateTimeSize() {
    double time;
    
    time = (0.0152 * pow(eggCircumference, 2)) * log(2 * (envTemp - 100) / (yolkTemp - 100));
    return time;
  }

  double calculateTimeWeight() {
    double time;
    time = (0.451 * pow(eggWeight, 2 / 3)) * log(0.76 * (envTemp - 100) / (yolkTemp - 100));
    return time;
  }
}   