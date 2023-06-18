import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plogger/view/plogging_camera_view.dart';
import 'package:plogger/view/plogging_map_view.dart';

class PloggingStatusView extends StatefulWidget {
  const PloggingStatusView({super.key});

  @override
  State<PloggingStatusView> createState() => _PloggingStatusViewState();
}

class _PloggingStatusViewState extends State<PloggingStatusView>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

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
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    Widget buildFloatingActionButton() {
      return FloatingActionButton.large(
        onPressed: () => Navigator.pop(context),
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
                      '2 Plastic',
                      style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/glass.png', width: 48, height: 48),
                    const SizedBox(height: 4),
                    Text(
                      '3 Glass',
                      style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/can.png', width: 48, height: 48),
                    const SizedBox(height: 4),
                    Text(
                      '5 Metal',
                      style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset('assets/trash.png', width: 48, height: 48),
                    const SizedBox(height: 4),
                    Text(
                      '0 Trash',
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
                      '2.35',
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
                      '12\'18\'\'',
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
                      '28:54',
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
                      '10',
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

    Route buildPloggingCameraViewRoute() {
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

    Widget buildIconButtons() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.outlined(
                onPressed: () => Navigator.push(
                  context,
                  buildPloggingMapViewRoute(),
                ),
                icon: Icon(
                  Icons.map_outlined,
                  color: cs.onPrimary,
                ),
              ),
              const SizedBox(
                width: 160,
              ),
              IconButton.outlined(
                onPressed: () => Navigator.push(
                  context,
                  buildPloggingCameraViewRoute(),
                ),
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

    String getCountdown() {
      double cd = animation.value;

      if (cd < 1) {
        return '3';
      } else if (cd < 2) {
        return '2';
      } else if (cd < 3) {
        return '1';
      } else {
        return 'PLOG!';
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
          child: Text(
            getCountdown(),
            style: tt.displayLarge
                ?.copyWith(color: cs.onPrimary, fontWeight: FontWeight.bold),
          ),
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
