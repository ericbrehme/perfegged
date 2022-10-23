class Eggsizes{
  // source: https://en.wikipedia.org/wiki/Chicken_egg_sizes

  // rough average weight of eu standard size eggs in grams (XS, XL, XXL - can be really vague, as ranges are high )
  static const egg_size_eu = {
    'XS':37,
    'S':47,
    'M':58,
    'L':68,
    'XL':78,
    'XXL':120
  };

  static const egg_size_eu_max = {
    'XS':40,
    'S':53,
    'M':63,
    'L':73,
    'XL':120
    //alles andere XXL
  };

  // rough average weight of us and canada standard size eggs in grams (Pewee, Jumbo - can be really vague, as ranges are high )
  static const egg_size_na = {
    'Peewee':39,
    'S':46,
    'M':53,
    'L':60,
    'XL':67,
    'Jumbo':75
  };

  // rough average weight of CIS standard size eggs in grams (3, B - can be really vague, as ranges are high )
  static const egg_size_cis = {
    '3':40,
    '2':50,
    '1':60,
    'О':70,
    'B':80
  };
}