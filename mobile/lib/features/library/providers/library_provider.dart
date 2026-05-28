import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/models.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/local_db_service.dart';

part 'library_provider.g.dart';

// ── Library state ──────────────────────────────────────────────────
@riverpod
class Library extends _$Library {
  @override
  Future<List<Manga>> build() async {
    // load from local DB first (offline-first)
    final local = await ref.read(localDbServiceProvider).getAllManga();
    if (local.isNotEmpty) return local;
    // then fetch from API
    return ref.read(apiServiceProvider).getLibrary();
  }

  Future<void> checkAllUpdates() async {
    ref.read(isCheckingAllProvider.notifier).state = true;
    try {
      final api = ref.read(apiServiceProvider);
      final updated = await api.checkAllUpdates();
      // merge into local DB
      await ref.read(localDbServiceProvider).upsertMangaList(updated);
      state = AsyncData(updated);
    } finally {
      ref.read(isCheckingAllProvider.notifier).state = false;
    }
  }

  Future<void> checkSingle(String mangaId) async {
    final api = ref.read(apiServiceProvider);
    final updated = await api.checkManga(mangaId);
    final current = state.valueOrNull ?? [];
    final newList = current.map((m) => m.id == mangaId ? updated : m).toList();
    await ref.read(localDbServiceProvider).upsertManga(updated);
    state = AsyncData(newList);
  }

  Future<void> updateProgress(String mangaId, double chapter) async {
    final api = ref.read(apiServiceProvider);
    await api.updateProgress(mangaId, chapter);
    final current = state.valueOrNull ?? [];
    final newList = current.map((m) {
      if (m.id != mangaId) return m;
      final hasUpdate = m.latestChapter != null && m.latestChapter! > chapter;
      return m.copyWith(lastReadChapter: chapter, hasUpdate: hasUpdate);
    }).toList();
    state = AsyncData(newList);
  }

  Future<void> removeFromLibrary(String mangaId) async {
    final api = ref.read(apiServiceProvider);
    await api.removeManga(mangaId);
    await ref.read(localDbServiceProvider).deleteManga(mangaId);
    final current = state.valueOrNull ?? [];
    state = AsyncData(current.where((m) => m.id != mangaId).toList());
  }

  Future<void> syncFromTrackers() async {
    ref.read(isCheckingAllProvider.notifier).state = true;
    try {
      final api = ref.read(apiServiceProvider);
      final synced = await api.syncTrackers();
      await ref.read(localDbServiceProvider).upsertMangaList(synced);
      state = AsyncData(synced);
    } finally {
      ref.read(isCheckingAllProvider.notifier).state = false;
    }
  }
}

// ── Checking state ─────────────────────────────────────────────────
@riverpod
class IsCheckingAll extends _$IsCheckingAll {
  @override
  bool build() => false;
}

// ── Stats ──────────────────────────────────────────────────────────
@riverpod
LibraryStats libraryStats(LibraryStatsRef ref) {
  final manga = ref.watch(libraryProvider).valueOrNull ?? [];
  return LibraryStats(
    total: manga.length,
    updates: manga.where((m) => m.hasUpdate).length,
    gaps: manga.where((m) => m.hasGap).length,
    upToDate: manga.where((m) => m.latestChapter != null && !m.hasUpdate).length,
    behind: manga.where((m) => m.chaptersBehind > 1).length,
  );
}

class LibraryStats {
  final int total;
  final int updates;
  final int gaps;
  final int upToDate;
  final int behind;

  const LibraryStats({
    required this.total,
    required this.updates,
    required this.gaps,
    required this.upToDate,
    required this.behind,
  });
}
