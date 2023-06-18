import 'package:flutter/material.dart';
import 'package:plogger/util/build.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BuildAppBar(pushed: true, title: 'Setting'),
      body: Center(
        child: Text('Setting'),
      ),
    );
  }
}
