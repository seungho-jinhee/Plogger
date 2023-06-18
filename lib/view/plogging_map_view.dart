import 'package:flutter/material.dart';

class PloggingMapView extends StatelessWidget {
  const PloggingMapView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;

    Widget buildFloatingActionButton() {
      return FloatingActionButton.large(
        onPressed: () => Navigator.pop(context),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        child: const Icon(Icons.navigate_next),
      );
    }

    return Scaffold(
      body: const Center(
        child: Text('Map'),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
