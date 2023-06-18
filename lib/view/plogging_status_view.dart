import 'package:flutter/material.dart';
import 'package:plogger/view/plogging_camera_view.dart';
import 'package:plogger/view/plogging_map_view.dart';

class PloggingStatusView extends StatelessWidget {
  const PloggingStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;

    Widget buildFloatingActionButton() {
      return FloatingActionButton.large(
        onPressed: () => Navigator.pop(context),
        backgroundColor: cs.onPrimary,
        foregroundColor: cs.primary,
        child: const Icon(Icons.stop),
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
                onPressed: () =>
                    Navigator.push(context, buildPloggingMapViewRoute()),
                icon: Icon(
                  Icons.map_outlined,
                  color: cs.onPrimary,
                ),
              ),
              const SizedBox(
                width: 160,
              ),
              IconButton.outlined(
                onPressed: () =>
                    Navigator.push(context, buildPloggingCameraViewRoute()),
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

    return Scaffold(
      backgroundColor: cs.primary,
      body: Stack(
        children: [
          const Center(
            child: Text('Status'),
          ),
          buildIconButtons(),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
