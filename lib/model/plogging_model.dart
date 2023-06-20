class PloggingModel {
  late String datetime;
  late int plastic;
  late int glass;
  late int metal;
  late int trash;
  late int time;
  late int steps;

  double get km => steps / 1000;
  int get pickedUp => plastic + glass + metal + trash;
  int get averagePace => km == 0 ? 0 : time ~/ km;

  PloggingModel({
    required this.datetime,
    this.plastic = 0,
    this.glass = 0,
    this.metal = 0,
    this.trash = 0,
    this.time = 0,
    this.steps = 0,
  });

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

  String toSTR() {
    return '$datetime $plastic $glass $metal $trash $time $steps,';
  }

  static List<PloggingModel> fromSTR(String str) {
    List<String> s = str.split(',');
    s = s.sublist(0, s.length - 1);
    List<List<String>> ss = List.generate(
      s.length,
      (index) => s[index].split(' '),
    );

    return List.generate(
      ss.length,
      (index) {
        List<String> sse = ss[index];
        return PloggingModel(
          datetime: sse[0],
          plastic: int.parse(sse[1]),
          glass: int.parse(sse[2]),
          metal: int.parse(sse[3]),
          trash: int.parse(sse[4]),
          time: int.parse(sse[5]),
          steps: int.parse(sse[6]),
        );
      },
    );
  }
}
