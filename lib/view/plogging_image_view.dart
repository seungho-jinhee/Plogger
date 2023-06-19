import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plogger/controller/roboflow_controller.dart';
import 'package:plogger/util/build.dart';

class PloggingImageView extends StatelessWidget {
  final String imagePath;

  const PloggingImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    late String type;

    Widget buildFloatingActionButton() {
      return FloatingActionButton.large(
        onPressed: () async {
          Navigator.pop(context);
          Navigator.pop(context, type);
        },
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        child: const Icon(Icons.done),
      );
    }

    return Scaffold(
      appBar: const BuildAppBar(pushed: true, title: 'Image'),
      body: FutureBuilder(
        future: Future(() => RoboflowController.detect(imagePath)),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            // dynamic image = snapshot.data!['image'];
            if (snapshot.data!['predictions'].isNotEmpty) {
              dynamic prediction = snapshot.data!['predictions'][0];
              type = prediction['class'];

              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(File(imagePath)),
                    Text(
                      '${prediction['class']} (${double.parse((prediction['confidence'] * 100).toString()).toInt()}%)',
                      style: tt.displaySmall?.copyWith(color: cs.primary),
                    ),
                    // SizedBox(
                    //   width: double.parse(image['width'].toString()),
                    //   height: double.parse(image['height'].toString()),
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //       left:
                    //           (prediction['x'] - (prediction['width'] / 2)) / 2,
                    //       top: (prediction['y'] - (prediction['height'] / 2)) /
                    //           2,
                    //       right: (double.parse(image['width'].toString()) -
                    //               (prediction['x'] +
                    //                   (prediction['width'] / 2))) /
                    //           2,
                    //       bottom: (double.parse(image['height'].toString()) -
                    //               (prediction['y'] +
                    //                   (prediction['height'] / 2))) /
                    //           2,
                    //     ),
                    //     child: Card(
                    //       color: Colors.transparent,
                    //       elevation: 0,
                    //       shape: RoundedRectangleBorder(
                    //         side: BorderSide(
                    //           width: 2,
                    //           color: cs.primary,
                    //         ),
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(12)),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(16),
                    //         child: Text(
                    //           '${prediction['class']} (${double.parse((prediction['confidence'] * 100).toString()).toInt()}%)',
                    //           style: tt.labelLarge?.copyWith(
                    //             color: cs.primary,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(File(imagePath)),
                    Text(
                      'Try Again',
                      style: tt.displaySmall?.copyWith(color: cs.error),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.file(File(imagePath)),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
