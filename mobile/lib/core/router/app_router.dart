import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/library/screens/library_screen.dart';
import '../../features/manga/screens/manga_detail_screen.dart';
import '../../features/stub_screens.dart';
import '../shell/main_shell.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/library',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull?.session != null;
      final isAuthRoute = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/onboarding');
      if (!isLoggedIn && !isAuthRoute) return null; // allow unauthenticated for now
      if (isLoggedIn && isAuthRoute) return '/library';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/library', pageBuilder: (_, __) => const NoTransitionPage(child: LibraryScreen())),
          GoRoute(path: '/updates', pageBuilder: (_, __) => const NoTransitionPage(child: UpdatesScreen())),
          GoRoute(path: '/history', pageBuilder: (_, __) => const NoTransitionPage(child: HistoryScreen())),
          GoRoute(path: '/browse',  pageBuilder: (_, __) => const NoTransitionPage(child: BrowseScreen())),
        ],
      ),
      GoRoute(
        path: '/manga/:id',
        builder: (context, state) => MangaDetailScreen(mangaId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const SettingsScreen(),
        routes: [
          GoRoute(path: 'trackers',      builder: (_, __) => const TrackersScreen()),
          GoRoute(path: 'notifications', builder: (_, __) => const NotificationsScreen()),
        ],
      ),
    ],
  );
}

class AppRoutes {
  static const login        = '/login';
  static const library      = '/library';
  static const updates      = '/updates';
  static const history      = '/history';
  static const browse       = '/browse';
  static const settings     = '/settings';
  static const trackers     = '/settings/trackers';
  static const notifications= '/settings/notifications';
  static String mangaDetail(String id) => '/manga/$id';
}
