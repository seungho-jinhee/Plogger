import 'package:flutter/material.dart';
import 'package:plogger/util/build.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BuildAppBar(pushed: true, title: 'Profile'),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
