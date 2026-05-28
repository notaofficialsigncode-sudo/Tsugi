import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  static const _tabs = [
    _NavTab(icon: Icons.grid_view_rounded, label: 'library', route: '/library'),
    _NavTab(icon: Icons.update_rounded, label: 'updates', route: '/updates'),
    _NavTab(icon: Icons.history_rounded, label: 'history', route: '/history'),
    _NavTab(icon: Icons.explore_outlined, label: 'browse', route: '/browse'),
  ];

  int _currentIndex(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final idx = _tabs.indexWhere((t) => loc.startsWith(t.route));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (i) => context.go(_tabs[i].route),
        destinations: _tabs.map((t) => NavigationDestination(
          icon: Icon(t.icon),
          label: t.label,
        )).toList(),
      ),
    );
  }
}

class _NavTab {
  final IconData icon;
  final String label;
  final String route;
  const _NavTab({required this.icon, required this.label, required this.route});
}
