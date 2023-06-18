import 'package:flutter/material.dart';
import 'package:plogger/view/profile_view.dart';
import 'package:plogger/view/setting_view.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool pushed;
  final bool tabBar;
  final String title;

  const BuildAppBar({
    super.key,
    this.pushed = false,
    this.tabBar = false,
    required this.title,
  });

  PreferredSizeWidget? buildTabBar() {
    return tabBar
        ? const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Total',
              ),
              Tab(
                text: 'Plastic',
              ),
              Tab(
                text: 'Glass',
              ),
              Tab(
                text: 'Metal',
              ),
            ],
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    if (pushed) {
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      );
    } else {
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, _buildProfileViewRoute()),
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, _buildSettingViewRoute()),
            icon: const Icon(Icons.settings),
          ),
        ],
        bottom: buildTabBar(),
      );
    }
  }

  Route _buildProfileViewRoute() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const ProfileView(),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final curveTween = CurveTween(curve: Curves.ease);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  Route _buildSettingViewRoute() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const SettingView(),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final curveTween = CurveTween(curve: Curves.ease);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
