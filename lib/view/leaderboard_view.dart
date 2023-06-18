import 'package:flutter/material.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Center(
          child: Text('Total'),
        ),
        Center(
          child: Text('Plastic'),
        ),
        Center(
          child: Text('Glass'),
        ),
        Center(
          child: Text('Metal'),
        ),
      ],
    );
  }
}
