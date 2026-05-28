import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/models.dart';

part 'local_db_service.g.dart';

// drift table
class MangaTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get coverUrl => text().nullable()();
  TextColumn get author => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get pubStatus => text().withDefault(const Constant('ongoing'))();
  TextColumn get contentType => text().withDefault(const Constant('manga'))();
  TextColumn get genres => text().withDefault(const Constant(''))();
  IntColumn get totalChapters => integer().nullable()();
  TextColumn get source => text()();
  TextColumn get sourceId => text()();
  TextColumn get mdxId => text().nullable()();
  RealColumn get lastReadChapter => real().withDefault(const Constant(0))();
  RealColumn get latestChapter => real().nullable()();
  TextColumn get latestSource => text().nullable()();
  BoolColumn get hasUpdate => boolean().withDefault(const Constant(false))();
  BoolColumn get hasGap => boolean().withDefault(const Constant(false))();
  TextColumn get gapJson => text().nullable()();
  DateTimeColumn get checkedAt => dateTime().nullable()();
  BoolColumn get notifyEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [MangaTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'tsugi'));

  @override
  int get schemaVersion => 1;

  Future<List<Manga>> getAllManga() async {
    final rows = await select(mangaTable).get();
    return rows.map(_toManga).toList();
  }

  Future<void> upsertManga(Manga m) =>
      into(mangaTable).insertOnConflictUpdate(_toRow(m));

  Future<void> upsertMangaList(List<Manga> list) => batch(
        (b) => b.insertAllOnConflictUpdate(mangaTable, list.map(_toRow).toList()),
      );

  Future<void> deleteManga(String id) =>
      (delete(mangaTable)..where((t) => t.id.equals(id))).go();

  Manga _toManga(MangaTableData r) => Manga(
        id: r.id,
        title: r.title,
        coverUrl: r.coverUrl,
        author: r.author,
        description: r.description,
        pubStatus: r.pubStatus,
        contentType: r.contentType,
        genres: r.genres.isEmpty ? [] : r.genres.split(','),
        totalChapters: r.totalChapters,
        source: r.source,
        sourceId: r.sourceId,
        mdxId: r.mdxId,
        lastReadChapter: r.lastReadChapter,
        latestChapter: r.latestChapter,
        latestSource: r.latestSource,
        hasUpdate: r.hasUpdate,
        hasGap: r.hasGap,
        gap: null,
        checkedAt: r.checkedAt,
        notifyEnabled: r.notifyEnabled,
      );

  MangaTableCompanion _toRow(Manga m) => MangaTableCompanion(
        id: Value(m.id),
        title: Value(m.title),
        coverUrl: Value(m.coverUrl),
        author: Value(m.author),
        description: Value(m.description),
        pubStatus: Value(m.pubStatus),
        contentType: Value(m.contentType),
        genres: Value(m.genres.join(',')),
        totalChapters: Value(m.totalChapters),
        source: Value(m.source),
        sourceId: Value(m.sourceId),
        mdxId: Value(m.mdxId),
        lastReadChapter: Value(m.lastReadChapter),
        latestChapter: Value(m.latestChapter),
        latestSource: Value(m.latestSource),
        hasUpdate: Value(m.hasUpdate),
        hasGap: Value(m.hasGap),
        checkedAt: Value(m.checkedAt),
        notifyEnabled: Value(m.notifyEnabled),
      );
}

@riverpod
LocalDbService localDbService(LocalDbServiceRef ref) => LocalDbService();

class LocalDbService {
  final _db = AppDatabase();
  Future<List<Manga>> getAllManga() => _db.getAllManga();
  Future<void> upsertManga(Manga m) => _db.upsertManga(m);
  Future<void> upsertMangaList(List<Manga> list) => _db.upsertMangaList(list);
  Future<void> deleteManga(String id) => _db.deleteManga(id);
}
