// stub screens — real UI coming next, these stop the router from crashing

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _pass  = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500, letterSpacing: -1),
                  children: [
                    TextSpan(text: 'tsugi', style: TextStyle(color: cs.onSurface)),
                    TextSpan(text: '.', style: TextStyle(color: cs.primary, fontSize: 42)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('manga chapter tracker', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 14)),
              const SizedBox(height: 40),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _pass,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'password'),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _loading ? null : _login,
                style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                child: _loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('sign in'),
              ),
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: _loading ? null : _signUp,
                style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                child: const Text('create account'),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => context.go('/library'),
                  child: Text('skip for now', style: TextStyle(color: cs.onSurfaceVariant)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      await ref.read(authNotifierProvider.notifier).signInWithEmail(_email.text.trim(), _pass.text);
      if (mounted) context.go('/library');
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _signUp() async {
    setState(() => _loading = true);
    try {
      await ref.read(authNotifierProvider.notifier).signUpWithEmail(_email.text.trim(), _pass.text);
      if (mounted) context.go('/onboarding');
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
    if (mounted) setState(() => _loading = false);
  }
}
