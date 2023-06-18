import 'package:flutter/material.dart';
import 'package:plogger/view/plogging_view.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Map'),
      ),
      body: const PloggingView(),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
