import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

@riverpod
Stream<AuthState> authState(AuthStateRef ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
}

@riverpod
User? currentUser(CurrentUserRef ref) {
  return Supabase.instance.client.auth.currentUser;
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<User?> build() {
    return AsyncData(Supabase.instance.client.auth.currentUser);
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      state = AsyncData(res.user);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      final res = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      state = AsyncData(res.user);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    state = const AsyncData(null);
  }
}
