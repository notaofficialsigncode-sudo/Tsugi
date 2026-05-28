import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';

part 'api_service.g.dart';

const _baseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://10.0.2.2:8000', // Android emulator localhost
);

@riverpod
ApiService apiService(ApiServiceRef ref) => ApiService();

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ));

    // logging in debug
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    // auth token interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        handler.next(options);
      },
    ));
  }

  // library (added trailing slash to match FastAPI exactly)
  Future<List<Manga>> getLibrary() async {
    final r = await _dio.get('/manga/');
    return (r.data as List).map((e) => Manga.fromJson(e)).toList();
  }

  // check updates
  Future<List<Manga>> checkAllUpdates() async {
    final r = await _dio.post('/check/all');
    return (r.data['manga'] as List).map((e) => Manga.fromJson(e)).toList();
  }

  // check single manga - Receives the complete row back safely
  Future<Manga> checkManga(Manga manga) async {
    final r = await _dio.post('/check/single', data: {
      'manga_id': manga.id,
      'title': manga.title,
      'mdx_id': manga.mdxId,
      'last_read': manga.lastReadChapter,
    });
    return Manga.fromJson(r.data);
  }

  // chapters
  Future<List<Chapter>> getChapters(String mangaId) async {
    final r = await _dio.get('/manga/$mangaId/chapters');
    return (r.data as List).map((e) => Chapter.fromJson(e)).toList();
  }

  // progress
  Future<void> updateProgress(String mangaId, double chapter) async {
    await _dio.put('/manga/$mangaId/progress', data: {'chapter': chapter});
  }

  // remove
  Future<void> removeManga(String mangaId) async {
    await _dio.delete('/manga/$mangaId');
  }

  // sync trackers
  Future<List<Manga>> syncTrackers() async {
    final r = await _dio.post('/sync/all');
    return (r.data['manga'] as List).map((e) => Manga.fromJson(e)).toList();
  }
}