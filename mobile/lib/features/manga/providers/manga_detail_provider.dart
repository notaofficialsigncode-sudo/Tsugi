import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/models.dart';
import '../../../core/services/api_service.dart';
import '../../library/providers/library_provider.dart';

part 'manga_detail_provider.g.dart';

@riverpod
Future<Manga> mangaDetail(MangaDetailRef ref, String mangaId) async {
  final library = await ref.watch(libraryProvider.future);
  final found = library.where((m) => m.id == mangaId).toList();
  if (found.isNotEmpty) return found.first;
  // fallback: fetch from API
  final list = await ref.read(apiServiceProvider).getLibrary();
  return list.firstWhere((m) => m.id == mangaId);
}

@riverpod
Future<List<Chapter>> chapterList(ChapterListRef ref, String mangaId) async {
  return ref.read(apiServiceProvider).getChapters(mangaId);
}
