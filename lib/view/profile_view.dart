import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plogger/util/build.dart';
import 'package:plogger/view/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const BuildAppBar(pushed: true, title: 'Profile'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(flex: 1, child: SizedBox()),
            const CircleAvatar(radius: 64),
            const SizedBox(height: 16),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString().split('@')[0],
              style: tt.headlineSmall?.copyWith(color: cs.onSurface),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();

                  // ignore: use_build_context_synchronously
                  Navigator.popUntil(context, (_) => false);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                } catch (e) {
                  // ignore: avoid_print
                  print(e);
                }
              },
              child: const Text('Sign Out'),
            ),
            const Expanded(flex: 8, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
