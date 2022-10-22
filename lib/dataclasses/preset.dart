class Preset {
  
  
  num? eggWeight;         // weight of the egg (may need to be calculated if not given directly by user)
  num? eggCircumference;  // Circumference of the egg (only used when user chooses to)
  num? envTemp;           // temperature in °C of the egg
  num? yolkTemp;          // desired temperature of yolk after cooking (yolk consistency depends on this)

  Preset({ required num eggWeight, required num envTemp, required num yolkTemp }) {
    // calculate cooking time from weight (most exact)
    this.eggWeight = eggWeight;
    this.envTemp = envTemp;
    this.yolkTemp = yolkTemp;
  }

  Preset.fromCircumference({ required num eggCircumference, required num envTemp, required num yolkTemp }) {
    // calculate cooking time from circumference (rough)

  }

  Preset.fromSize({ required String eggSize, required num envTemp, required num yolkTemp }) {
    // calculate cooking time from weight which is the average of given standart size (rough)
  }



}   