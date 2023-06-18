import 'package:flutter/material.dart';
import 'package:plogger/util/build.dart';
import 'package:plogger/view/plogging_view.dart';

class PloggingMapView extends StatelessWidget {
  const PloggingMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BuildAppBar(pushed: true, title: 'Map'),
      body: PloggingView(),
    );
  }
}
