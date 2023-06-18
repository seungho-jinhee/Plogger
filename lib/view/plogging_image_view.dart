import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plogger/util/build.dart';

class PloggingImageView extends StatelessWidget {
  final String imagePath;

  const PloggingImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;

    Widget buildFloatingActionButton() {
      return FloatingActionButton.large(
        onPressed: () async {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        child: const Icon(Icons.done),
      );
    }

    return Scaffold(
      appBar: const BuildAppBar(pushed: true, title: 'Image'),
      body: Center(child: Image.file(File(imagePath))),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
