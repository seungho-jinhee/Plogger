import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plogger/util/build.dart';
import 'package:plogger/view/plogging_image_view.dart';
import 'package:vibration/vibration.dart';

class PloggingCameraView extends StatelessWidget {
  const PloggingCameraView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    late CameraController cameraController;

    Route buildPloggingImageViewRoute(String imagePath) {
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => PloggingImageView(imagePath: imagePath),
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

    Widget buildFloatingActionButton() {
      return FloatingActionButton.large(
        onPressed: () async {
          Vibration.vibrate();
          XFile image = await cameraController.takePicture();
          // ignore: use_build_context_synchronously
          Navigator.push(context, buildPloggingImageViewRoute(image.path));
        },
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        child: const Icon(Icons.camera_alt),
      );
    }

    return Scaffold(
      appBar: const BuildAppBar(pushed: true, title: 'Camera'),
      body: Center(
        child: FutureBuilder(
          future: Future(() async {
            cameraController = CameraController(
              (await availableCameras()).first,
              ResolutionPreset.max,
            );
            await cameraController.initialize();
          }),
          builder: (_, snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? CameraPreview(cameraController)
                : const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
