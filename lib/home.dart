import 'package:flutter/material.dart';
import 'package:plogger/util/build.dart';
import 'package:plogger/view/activity_view.dart';
import 'package:plogger/view/leaderboard_view.dart';
import 'package:plogger/view/plogging_view.dart';
import 'package:plogger/view/plogging_status_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;

    String getTitle() {
      switch (_selectedIndex) {
        case 0:
          return 'Leaderboard';
        case 1:
          return 'Plogging';
        case 2:
          return 'Activity';
        default:
          return 'Plogging';
      }
    }

    PreferredSizeWidget buildAppBar() {
      return BuildAppBar(pushed: false, title: getTitle());
    }

    Widget buildBody() {
      switch (_selectedIndex) {
        case 0:
          return const LeaderboardView();
        case 1:
          return const PloggingView();
        case 2:
          return const ActivityView();
        default:
          return const PloggingView();
      }
    }

    NavigationBar buildBottomNavigationBar() {
      return NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(
              _selectedIndex == 0
                  ? Icons.leaderboard
                  : Icons.leaderboard_outlined,
            ),
            label: 'Leaderboard',
          ),
          NavigationDestination(
            icon: Icon(
              _selectedIndex == 1
                  ? Icons.directions_run
                  : Icons.directions_run_outlined,
            ),
            label: 'Plogging',
          ),
          NavigationDestination(
            icon: Icon(
              _selectedIndex == 2 ? Icons.history : Icons.history_outlined,
            ),
            label: 'Acitivity',
          ),
        ],
        onDestinationSelected: (value) => setState(
          () => _selectedIndex = value,
        ),
      );
    }

    Widget? buildFloatingActionButton() {
      Route buildPloggingStatusViewRoute() {
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PloggingStatusView(),
          transitionsBuilder: (_, animation, __, child) {
            const begin = Offset(0.0, -1.0);
            const end = Offset.zero;
            final curveTween = CurveTween(curve: Curves.ease);
            final tween = Tween(begin: begin, end: end).chain(curveTween);
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
      }

      return _selectedIndex == 1
          ? FloatingActionButton.large(
              onPressed: () =>
                  Navigator.push(context, buildPloggingStatusViewRoute()),
              backgroundColor: cs.primary,
              foregroundColor: cs.onPrimary,
              child: const Icon(Icons.play_arrow),
            )
          : null;
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
