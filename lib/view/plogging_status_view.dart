import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedometer/pedometer.dart';
import 'package:plogger/model/plogging_model.dart';
import 'package:plogger/util/constant.dart';
import 'package:plogger/view/plogging_camera_view.dart';
import 'package:plogger/view/plogging_map_view.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

class PloggingStatusView extends StatefulWidget {
  const PloggingStatusView({super.key});

  @override
  State<PloggingStatusView> createState() => _PloggingStatusViewState();
}

class _PloggingStatusViewState extends State<PloggingStatusView>
    with SingleTickerProviderStateMixin {
  late PloggingModel ploggingModel;
  late Animation<double> animation;
  late AnimationController animationController;

  Route buildPloggingMapViewRoute() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const PloggingMapView(),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        final curveTween = CurveTween(curve: Curves.ease);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  Route<String> buildPloggingCameraViewRoute() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const PloggingCameraView(),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final curveTween = CurveTween(curve: Curves.ease);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 4).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();

    Future.delayed(const Duration(seconds: 3)).then(
      (_) {
        ploggingModel = PloggingModel(
          datetime: DateTime.now().toIso8601String().substring(0, 19),
        );
        Pedometer.stepCountStream.listen((event) {
          ploggingModel.steps += 1;
        });
        gyroscopeEvents.listen((event) async {
          if (event.x < GYROSCOPE_EVENTS_THRESHOLD) {
            Vibration.vibrate();

            String? type = await Navigator.push(
              context,
              buildPloggingCameraViewRoute(),
            );

            if (type != null) {
              setState(() => ploggingModel.updatePickedUp(type));
            }
          }
        });
        Timer.periodic(const Duration(seconds: 1), (_) {
          setState(() {
            ploggingModel.time += 1;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    Widget buildFloatingActionButton() {
      return FloatingActionButton.large(
        onPressed: () {
          Pedometer.pedestrianStatusStream.drain();
          gyroscopeEvents.drain();
          Navigator.pop(context, ploggingModel);
        },
        backgroundColor: cs.onPrimary,
        foregroundColor: cs.primary,
        child: const Icon(Icons.stop),
      );
    }

    Widget buildStatus() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset('assets/bottle.png', width: 48, height: 48),
                    const SizedBox(height: 4),
                    Text(
                      '${ploggingModel.plastic} Plastic',
                      style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/glass.png', width: 48, height: 48),
                    const SizedBox(height: 4),
                    Text(
                      '${ploggingModel.glass} Glass',
                      style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/can.png', width: 48, height: 48),
                    const SizedBox(height: 4),
                    Text(
                      '${ploggingModel.metal} Metal',
                      style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/trash.png', width: 48, height: 48),
                    const SizedBox(height: 4),
                    Text(
                      '${ploggingModel.trash} Trash',
                      style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ploggingModel.km.toStringAsFixed(2),
                      style: tt.headlineLarge?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Km',
                      style: tt.titleSmall?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${ploggingModel.averagePace ~/ 60}\'${ploggingModel.averagePace % 60}\'\'',
                      style: tt.headlineLarge?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Average Pace',
                      style: tt.titleSmall?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${ploggingModel.time ~/ 60}:${ploggingModel.time % 60}',
                      style: tt.headlineLarge?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Time',
                      style: tt.titleSmall?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${ploggingModel.pickedUp}',
                      style: tt.headlineLarge?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Picked Up',
                      style: tt.titleSmall?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buildIconButtons() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.outlined(
                onPressed: () {
                  Navigator.push(
                    context,
                    buildPloggingMapViewRoute(),
                  );
                },
                icon: Icon(
                  Icons.map_outlined,
                  color: cs.onPrimary,
                ),
              ),
              const SizedBox(
                width: 160,
              ),
              IconButton.outlined(
                onPressed: () async {
                  String? type = await Navigator.push(
                    context,
                    buildPloggingCameraViewRoute(),
                  );

                  if (type != null) {
                    setState(() => ploggingModel.updatePickedUp(type));
                  }
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: cs.onPrimary,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      );
    }

    Widget getCountdown() {
      double cd = animation.value;

      if (cd < 1) {
        return Text(
          '3',
          style: tt.displayLarge?.copyWith(
            color: cs.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        );
      } else if (cd < 2) {
        return Text(
          '2',
          style: tt.displayLarge?.copyWith(
            color: cs.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        );
      } else if (cd < 3) {
        return Text(
          '1',
          style: tt.displayLarge?.copyWith(
            color: cs.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        );
      } else {
        return Text(
          'PLOGGING\nTOGETHER!',
          style: tt.displaySmall?.copyWith(
            color: cs.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        );
      }
    }

    Widget buildAnimation() {
      return Scaffold(
        backgroundColor: cs.primary,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Plogging'),
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: Center(
          child: getCountdown(),
        ),
      );
    }

    Widget buildScaffold() {
      return Scaffold(
        backgroundColor: cs.primary,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Plogging'),
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: Stack(
          children: [
            buildStatus(),
            buildIconButtons(),
          ],
        ),
        floatingActionButton: buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }

    return animation.value < 4 ? buildAnimation() : buildScaffold();
  }
}
