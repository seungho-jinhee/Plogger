import 'dart:math';

class PloggingModel {
  int plastic = 0;
  int glass = 0;
  int metal = 0;
  int trash = 0;
  int time = 0;
  int steps = 0;

  // double dxdt = 0;
  // double x = 0;
  // double dydt = 0;
  // double y = 0;
  // double dzdt = 0;
  // double z = 0;

  // double get km => sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)).toDouble() / 1000;
  double get km => steps / 1000;
  int get pickedUp => plastic + glass + metal + trash;
  int get averagePace => km == 0 ? 0 : time ~/ km;

  void updatePickedUp(String type) {
    print('updatePickedUp($type)');
    switch (type) {
      case 'plastic':
        plastic += 1;
        break;
      case 'glass':
        glass += 1;
      case 'metal':
        metal += 1;
      default:
        trash += 1;
    }
  }

  // void update(double d2xdt2, double d2ydt2, double d2zdt2) {
  //   print('update($d2xdt2, $d2ydt2, $d2zdt2)');
  //   dxdt += d2xdt2;
  //   dydt += d2ydt2;
  //   dzdt += d2zdt2;

  //   x += (dxdt > 0 ? dxdt : -dxdt);
  //   y += (dydt > 0 ? dydt : -dydt);
  //   z += (dzdt > 0 ? dzdt : -dzdt);

  //   time += 1;
  // }
}
