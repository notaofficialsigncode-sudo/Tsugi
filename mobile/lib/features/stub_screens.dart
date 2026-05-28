import 'package:flutter/material.dart';

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({super.key});
  @override
  Widget build(BuildContext context) => const _Stub(label: 'updates', icon: Icons.update_rounded);
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) => const _Stub(label: 'history', icon: Icons.history_rounded);
}

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});
  @override
  Widget build(BuildContext context) => const _Stub(label: 'browse', icon: Icons.explore_outlined);
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => const _Stub(label: 'settings', icon: Icons.settings_outlined);
}

class TrackersScreen extends StatelessWidget {
  const TrackersScreen({super.key});
  @override
  Widget build(BuildContext context) => const _Stub(label: 'trackers', icon: Icons.sync_rounded);
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => const _Stub(label: 'notifications', icon: Icons.notifications_outlined);
}

// placeholder widget used by all stub screens
class _Stub extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Stub({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: cs.onSurfaceVariant.withValues(alpha: 0.4)),
            const SizedBox(height: 12),
            Text(
              '$label — coming soon',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
