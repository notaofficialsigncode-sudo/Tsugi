// onboarding
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('connect your trackers', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go('/settings/trackers'),
              child: const Text('set up trackers'),
            ),
            TextButton(
              onPressed: () => context.go('/library'),
              child: const Text('skip'),
            ),
          ],
        ),
      ),
    );
  }
}
