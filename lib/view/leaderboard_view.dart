import 'package:flutter/material.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    Widget buildCard() {
      return Expanded(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: cs.outline),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Seungho Jang', style: tt.titleMedium),
                    Text('235 Picked Up', style: tt.bodyMedium),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget getMyLeaderboard() {
      return Row(
        children: [
          Text('35', style: tt.headlineLarge),
          const SizedBox(width: 32),
          buildCard(),
        ],
      );
    }

    List<Widget> getGlobalLeaderboard() {
      return List.generate(
        20,
        (index) => Column(
          children: [
            SizedBox(height: index == 0 ? 0 : 8),
            Row(
              children: [
                Text(
                  ((index + 1) > 9 ? '' : '0') + (index + 1).toString(),
                  style: tt.headlineLarge,
                ),
                const SizedBox(width: 32),
                buildCard(),
              ],
            ),
            SizedBox(height: index == 20 - 1 ? 0 : 8),
          ],
        ),
      );
    }

    Widget buildLeaderboard() {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Leaderboard',
                  style: tt.bodyLarge,
                ),
                const SizedBox(height: 16),
                getMyLeaderboard(),
                const SizedBox(height: 16),
                Text(
                  'Global Leaderboard',
                  style: tt.bodyLarge,
                ),
                const SizedBox(height: 16),
                ...getGlobalLeaderboard(),
              ],
            ),
          ],
        ),
      );
    }

    return TabBarView(
      children: <Widget>[
        buildLeaderboard(),
        buildLeaderboard(),
        buildLeaderboard(),
        buildLeaderboard(),
      ],
    );
  }
}
