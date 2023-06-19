class PloggingModel {
  int plastic = 0;
  int glass = 0;
  int metal = 0;
  int trash = 0;
  int time = 0;
  int steps = 0;

  double get km => steps / 1000;
  int get pickedUp => plastic + glass + metal + trash;
  int get averagePace => km == 0 ? 0 : time ~/ km;

  void updatePickedUp(String type) {
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
}
