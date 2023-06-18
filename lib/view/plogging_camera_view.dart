import 'package:flutter/material.dart';

class PloggingCameraView extends StatelessWidget {
  const PloggingCameraView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;

    Widget buildFloatingActionButton() {
      return FloatingActionButton.large(
        onPressed: () => Navigator.pop(context),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        child: const Icon(Icons.navigate_before),
      );
    }

    return Scaffold(
      body: const Center(
        child: Text('Camera'),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
