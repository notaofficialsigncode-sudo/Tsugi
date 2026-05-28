// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db_service.dart';

// ignore_for_file: type=lint
class $MangaTableTable extends MangaTable
    with TableInfo<$MangaTableTable, MangaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MangaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverUrlMeta =
      const VerificationMeta('coverUrl');
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
      'cover_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pubStatusMeta =
      const VerificationMeta('pubStatus');
  @override
  late final GeneratedColumn<String> pubStatus = GeneratedColumn<String>(
      'pub_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ongoing'));
  static const VerificationMeta _contentTypeMeta =
      const VerificationMeta('contentType');
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
      'content_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manga'));
  static const VerificationMeta _genresMeta = const VerificationMeta('genres');
  @override
  late final GeneratedColumn<String> genres = GeneratedColumn<String>(
      'genres', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _totalChaptersMeta =
      const VerificationMeta('totalChapters');
  @override
  late final GeneratedColumn<int> totalChapters = GeneratedColumn<int>(
      'total_chapters', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mdxIdMeta = const VerificationMeta('mdxId');
  @override
  late final GeneratedColumn<String> mdxId = GeneratedColumn<String>(
      'mdx_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastReadChapterMeta =
      const VerificationMeta('lastReadChapter');
  @override
  late final GeneratedColumn<double> lastReadChapter = GeneratedColumn<double>(
      'last_read_chapter', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _latestChapterMeta =
      const VerificationMeta('latestChapter');
  @override
  late final GeneratedColumn<double> latestChapter = GeneratedColumn<double>(
      'latest_chapter', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _latestSourceMeta =
      const VerificationMeta('latestSource');
  @override
  late final GeneratedColumn<String> latestSource = GeneratedColumn<String>(
      'latest_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hasUpdateMeta =
      const VerificationMeta('hasUpdate');
  @override
  late final GeneratedColumn<bool> hasUpdate = GeneratedColumn<bool>(
      'has_update', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_update" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasGapMeta = const VerificationMeta('hasGap');
  @override
  late final GeneratedColumn<bool> hasGap = GeneratedColumn<bool>(
      'has_gap', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_gap" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _gapJsonMeta =
      const VerificationMeta('gapJson');
  @override
  late final GeneratedColumn<String> gapJson = GeneratedColumn<String>(
      'gap_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _checkedAtMeta =
      const VerificationMeta('checkedAt');
  @override
  late final GeneratedColumn<DateTime> checkedAt = GeneratedColumn<DateTime>(
      'checked_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notifyEnabledMeta =
      const VerificationMeta('notifyEnabled');
  @override
  late final GeneratedColumn<bool> notifyEnabled = GeneratedColumn<bool>(
      'notify_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notify_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        coverUrl,
        author,
        description,
        pubStatus,
        contentType,
        genres,
        totalChapters,
        source,
        sourceId,
        mdxId,
        lastReadChapter,
        latestChapter,
        latestSource,
        hasUpdate,
        hasGap,
        gapJson,
        checkedAt,
        notifyEnabled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'manga_table';
  @override
  VerificationContext validateIntegrity(Insertable<MangaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cover_url')) {
      context.handle(_coverUrlMeta,
          coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('pub_status')) {
      context.handle(_pubStatusMeta,
          pubStatus.isAcceptableOrUnknown(data['pub_status']!, _pubStatusMeta));
    }
    if (data.containsKey('content_type')) {
      context.handle(
          _contentTypeMeta,
          contentType.isAcceptableOrUnknown(
              data['content_type']!, _contentTypeMeta));
    }
    if (data.containsKey('genres')) {
      context.handle(_genresMeta,
          genres.isAcceptableOrUnknown(data['genres']!, _genresMeta));
    }
    if (data.containsKey('total_chapters')) {
      context.handle(
          _totalChaptersMeta,
          totalChapters.isAcceptableOrUnknown(
              data['total_chapters']!, _totalChaptersMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('mdx_id')) {
      context.handle(
          _mdxIdMeta, mdxId.isAcceptableOrUnknown(data['mdx_id']!, _mdxIdMeta));
    }
    if (data.containsKey('last_read_chapter')) {
      context.handle(
          _lastReadChapterMeta,
          lastReadChapter.isAcceptableOrUnknown(
              data['last_read_chapter']!, _lastReadChapterMeta));
    }
    if (data.containsKey('latest_chapter')) {
      context.handle(
          _latestChapterMeta,
          latestChapter.isAcceptableOrUnknown(
              data['latest_chapter']!, _latestChapterMeta));
    }
    if (data.containsKey('latest_source')) {
      context.handle(
          _latestSourceMeta,
          latestSource.isAcceptableOrUnknown(
              data['latest_source']!, _latestSourceMeta));
    }
    if (data.containsKey('has_update')) {
      context.handle(_hasUpdateMeta,
          hasUpdate.isAcceptableOrUnknown(data['has_update']!, _hasUpdateMeta));
    }
    if (data.containsKey('has_gap')) {
      context.handle(_hasGapMeta,
          hasGap.isAcceptableOrUnknown(data['has_gap']!, _hasGapMeta));
    }
    if (data.containsKey('gap_json')) {
      context.handle(_gapJsonMeta,
          gapJson.isAcceptableOrUnknown(data['gap_json']!, _gapJsonMeta));
    }
    if (data.containsKey('checked_at')) {
      context.handle(_checkedAtMeta,
          checkedAt.isAcceptableOrUnknown(data['checked_at']!, _checkedAtMeta));
    }
    if (data.containsKey('notify_enabled')) {
      context.handle(
          _notifyEnabledMeta,
          notifyEnabled.isAcceptableOrUnknown(
              data['notify_enabled']!, _notifyEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MangaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MangaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      coverUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_url']),
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      pubStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pub_status'])!,
      contentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_type'])!,
      genres: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genres'])!,
      totalChapters: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_chapters']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id'])!,
      mdxId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mdx_id']),
      lastReadChapter: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}last_read_chapter'])!,
      latestChapter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latest_chapter']),
      latestSource: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}latest_source']),
      hasUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_update'])!,
      hasGap: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_gap'])!,
      gapJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gap_json']),
      checkedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}checked_at']),
      notifyEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}notify_enabled'])!,
    );
  }

  @override
  $MangaTableTable createAlias(String alias) {
    return $MangaTableTable(attachedDatabase, alias);
  }
}

class MangaTableData extends DataClass implements Insertable<MangaTableData> {
  final String id;
  final String title;
  final String? coverUrl;
  final String? author;
  final String? description;
  final String pubStatus;
  final String contentType;
  final String genres;
  final int? totalChapters;
  final String source;
  final String sourceId;
  final String? mdxId;
  final double lastReadChapter;
  final double? latestChapter;
  final String? latestSource;
  final bool hasUpdate;
  final bool hasGap;
  final String? gapJson;
  final DateTime? checkedAt;
  final bool notifyEnabled;
  const MangaTableData(
      {required this.id,
      required this.title,
      this.coverUrl,
      this.author,
      this.description,
      required this.pubStatus,
      required this.contentType,
      required this.genres,
      this.totalChapters,
      required this.source,
      required this.sourceId,
      this.mdxId,
      required this.lastReadChapter,
      this.latestChapter,
      this.latestSource,
      required this.hasUpdate,
      required this.hasGap,
      this.gapJson,
      this.checkedAt,
      required this.notifyEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['pub_status'] = Variable<String>(pubStatus);
    map['content_type'] = Variable<String>(contentType);
    map['genres'] = Variable<String>(genres);
    if (!nullToAbsent || totalChapters != null) {
      map['total_chapters'] = Variable<int>(totalChapters);
    }
    map['source'] = Variable<String>(source);
    map['source_id'] = Variable<String>(sourceId);
    if (!nullToAbsent || mdxId != null) {
      map['mdx_id'] = Variable<String>(mdxId);
    }
    map['last_read_chapter'] = Variable<double>(lastReadChapter);
    if (!nullToAbsent || latestChapter != null) {
      map['latest_chapter'] = Variable<double>(latestChapter);
    }
    if (!nullToAbsent || latestSource != null) {
      map['latest_source'] = Variable<String>(latestSource);
    }
    map['has_update'] = Variable<bool>(hasUpdate);
    map['has_gap'] = Variable<bool>(hasGap);
    if (!nullToAbsent || gapJson != null) {
      map['gap_json'] = Variable<String>(gapJson);
    }
    if (!nullToAbsent || checkedAt != null) {
      map['checked_at'] = Variable<DateTime>(checkedAt);
    }
    map['notify_enabled'] = Variable<bool>(notifyEnabled);
    return map;
  }

  MangaTableCompanion toCompanion(bool nullToAbsent) {
    return MangaTableCompanion(
      id: Value(id),
      title: Value(title),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      pubStatus: Value(pubStatus),
      contentType: Value(contentType),
      genres: Value(genres),
      totalChapters: totalChapters == null && nullToAbsent
          ? const Value.absent()
          : Value(totalChapters),
      source: Value(source),
      sourceId: Value(sourceId),
      mdxId:
          mdxId == null && nullToAbsent ? const Value.absent() : Value(mdxId),
      lastReadChapter: Value(lastReadChapter),
      latestChapter: latestChapter == null && nullToAbsent
          ? const Value.absent()
          : Value(latestChapter),
      latestSource: latestSource == null && nullToAbsent
          ? const Value.absent()
          : Value(latestSource),
      hasUpdate: Value(hasUpdate),
      hasGap: Value(hasGap),
      gapJson: gapJson == null && nullToAbsent
          ? const Value.absent()
          : Value(gapJson),
      checkedAt: checkedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(checkedAt),
      notifyEnabled: Value(notifyEnabled),
    );
  }

  factory MangaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MangaTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      author: serializer.fromJson<String?>(json['author']),
      description: serializer.fromJson<String?>(json['description']),
      pubStatus: serializer.fromJson<String>(json['pubStatus']),
      contentType: serializer.fromJson<String>(json['contentType']),
      genres: serializer.fromJson<String>(json['genres']),
      totalChapters: serializer.fromJson<int?>(json['totalChapters']),
      source: serializer.fromJson<String>(json['source']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      mdxId: serializer.fromJson<String?>(json['mdxId']),
      lastReadChapter: serializer.fromJson<double>(json['lastReadChapter']),
      latestChapter: serializer.fromJson<double?>(json['latestChapter']),
      latestSource: serializer.fromJson<String?>(json['latestSource']),
      hasUpdate: serializer.fromJson<bool>(json['hasUpdate']),
      hasGap: serializer.fromJson<bool>(json['hasGap']),
      gapJson: serializer.fromJson<String?>(json['gapJson']),
      checkedAt: serializer.fromJson<DateTime?>(json['checkedAt']),
      notifyEnabled: serializer.fromJson<bool>(json['notifyEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'author': serializer.toJson<String?>(author),
      'description': serializer.toJson<String?>(description),
      'pubStatus': serializer.toJson<String>(pubStatus),
      'contentType': serializer.toJson<String>(contentType),
      'genres': serializer.toJson<String>(genres),
      'totalChapters': serializer.toJson<int?>(totalChapters),
      'source': serializer.toJson<String>(source),
      'sourceId': serializer.toJson<String>(sourceId),
      'mdxId': serializer.toJson<String?>(mdxId),
      'lastReadChapter': serializer.toJson<double>(lastReadChapter),
      'latestChapter': serializer.toJson<double?>(latestChapter),
      'latestSource': serializer.toJson<String?>(latestSource),
      'hasUpdate': serializer.toJson<bool>(hasUpdate),
      'hasGap': serializer.toJson<bool>(hasGap),
      'gapJson': serializer.toJson<String?>(gapJson),
      'checkedAt': serializer.toJson<DateTime?>(checkedAt),
      'notifyEnabled': serializer.toJson<bool>(notifyEnabled),
    };
  }

  MangaTableData copyWith(
          {String? id,
          String? title,
          Value<String?> coverUrl = const Value.absent(),
          Value<String?> author = const Value.absent(),
          Value<String?> description = const Value.absent(),
          String? pubStatus,
          String? contentType,
          String? genres,
          Value<int?> totalChapters = const Value.absent(),
          String? source,
          String? sourceId,
          Value<String?> mdxId = const Value.absent(),
          double? lastReadChapter,
          Value<double?> latestChapter = const Value.absent(),
          Value<String?> latestSource = const Value.absent(),
          bool? hasUpdate,
          bool? hasGap,
          Value<String?> gapJson = const Value.absent(),
          Value<DateTime?> checkedAt = const Value.absent(),
          bool? notifyEnabled}) =>
      MangaTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
        author: author.present ? author.value : this.author,
        description: description.present ? description.value : this.description,
        pubStatus: pubStatus ?? this.pubStatus,
        contentType: contentType ?? this.contentType,
        genres: genres ?? this.genres,
        totalChapters:
            totalChapters.present ? totalChapters.value : this.totalChapters,
        source: source ?? this.source,
        sourceId: sourceId ?? this.sourceId,
        mdxId: mdxId.present ? mdxId.value : this.mdxId,
        lastReadChapter: lastReadChapter ?? this.lastReadChapter,
        latestChapter:
            latestChapter.present ? latestChapter.value : this.latestChapter,
        latestSource:
            latestSource.present ? latestSource.value : this.latestSource,
        hasUpdate: hasUpdate ?? this.hasUpdate,
        hasGap: hasGap ?? this.hasGap,
        gapJson: gapJson.present ? gapJson.value : this.gapJson,
        checkedAt: checkedAt.present ? checkedAt.value : this.checkedAt,
        notifyEnabled: notifyEnabled ?? this.notifyEnabled,
      );
  MangaTableData copyWithCompanion(MangaTableCompanion data) {
    return MangaTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      author: data.author.present ? data.author.value : this.author,
      description:
          data.description.present ? data.description.value : this.description,
      pubStatus: data.pubStatus.present ? data.pubStatus.value : this.pubStatus,
      contentType:
          data.contentType.present ? data.contentType.value : this.contentType,
      genres: data.genres.present ? data.genres.value : this.genres,
      totalChapters: data.totalChapters.present
          ? data.totalChapters.value
          : this.totalChapters,
      source: data.source.present ? data.source.value : this.source,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      mdxId: data.mdxId.present ? data.mdxId.value : this.mdxId,
      lastReadChapter: data.lastReadChapter.present
          ? data.lastReadChapter.value
          : this.lastReadChapter,
      latestChapter: data.latestChapter.present
          ? data.latestChapter.value
          : this.latestChapter,
      latestSource: data.latestSource.present
          ? data.latestSource.value
          : this.latestSource,
      hasUpdate: data.hasUpdate.present ? data.hasUpdate.value : this.hasUpdate,
      hasGap: data.hasGap.present ? data.hasGap.value : this.hasGap,
      gapJson: data.gapJson.present ? data.gapJson.value : this.gapJson,
      checkedAt: data.checkedAt.present ? data.checkedAt.value : this.checkedAt,
      notifyEnabled: data.notifyEnabled.present
          ? data.notifyEnabled.value
          : this.notifyEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MangaTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('pubStatus: $pubStatus, ')
          ..write('contentType: $contentType, ')
          ..write('genres: $genres, ')
          ..write('totalChapters: $totalChapters, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('mdxId: $mdxId, ')
          ..write('lastReadChapter: $lastReadChapter, ')
          ..write('latestChapter: $latestChapter, ')
          ..write('latestSource: $latestSource, ')
          ..write('hasUpdate: $hasUpdate, ')
          ..write('hasGap: $hasGap, ')
          ..write('gapJson: $gapJson, ')
          ..write('checkedAt: $checkedAt, ')
          ..write('notifyEnabled: $notifyEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      coverUrl,
      author,
      description,
      pubStatus,
      contentType,
      genres,
      totalChapters,
      source,
      sourceId,
      mdxId,
      lastReadChapter,
      latestChapter,
      latestSource,
      hasUpdate,
      hasGap,
      gapJson,
      checkedAt,
      notifyEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MangaTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.coverUrl == this.coverUrl &&
          other.author == this.author &&
          other.description == this.description &&
          other.pubStatus == this.pubStatus &&
          other.contentType == this.contentType &&
          other.genres == this.genres &&
          other.totalChapters == this.totalChapters &&
          other.source == this.source &&
          other.sourceId == this.sourceId &&
          other.mdxId == this.mdxId &&
          other.lastReadChapter == this.lastReadChapter &&
          other.latestChapter == this.latestChapter &&
          other.latestSource == this.latestSource &&
          other.hasUpdate == this.hasUpdate &&
          other.hasGap == this.hasGap &&
          other.gapJson == this.gapJson &&
          other.checkedAt == this.checkedAt &&
          other.notifyEnabled == this.notifyEnabled);
}

class MangaTableCompanion extends UpdateCompanion<MangaTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> coverUrl;
  final Value<String?> author;
  final Value<String?> description;
  final Value<String> pubStatus;
  final Value<String> contentType;
  final Value<String> genres;
  final Value<int?> totalChapters;
  final Value<String> source;
  final Value<String> sourceId;
  final Value<String?> mdxId;
  final Value<double> lastReadChapter;
  final Value<double?> latestChapter;
  final Value<String?> latestSource;
  final Value<bool> hasUpdate;
  final Value<bool> hasGap;
  final Value<String?> gapJson;
  final Value<DateTime?> checkedAt;
  final Value<bool> notifyEnabled;
  final Value<int> rowid;
  const MangaTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.pubStatus = const Value.absent(),
    this.contentType = const Value.absent(),
    this.genres = const Value.absent(),
    this.totalChapters = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.mdxId = const Value.absent(),
    this.lastReadChapter = const Value.absent(),
    this.latestChapter = const Value.absent(),
    this.latestSource = const Value.absent(),
    this.hasUpdate = const Value.absent(),
    this.hasGap = const Value.absent(),
    this.gapJson = const Value.absent(),
    this.checkedAt = const Value.absent(),
    this.notifyEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MangaTableCompanion.insert({
    required String id,
    required String title,
    this.coverUrl = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.pubStatus = const Value.absent(),
    this.contentType = const Value.absent(),
    this.genres = const Value.absent(),
    this.totalChapters = const Value.absent(),
    required String source,
    required String sourceId,
    this.mdxId = const Value.absent(),
    this.lastReadChapter = const Value.absent(),
    this.latestChapter = const Value.absent(),
    this.latestSource = const Value.absent(),
    this.hasUpdate = const Value.absent(),
    this.hasGap = const Value.absent(),
    this.gapJson = const Value.absent(),
    this.checkedAt = const Value.absent(),
    this.notifyEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        source = Value(source),
        sourceId = Value(sourceId);
  static Insertable<MangaTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? coverUrl,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? pubStatus,
    Expression<String>? contentType,
    Expression<String>? genres,
    Expression<int>? totalChapters,
    Expression<String>? source,
    Expression<String>? sourceId,
    Expression<String>? mdxId,
    Expression<double>? lastReadChapter,
    Expression<double>? latestChapter,
    Expression<String>? latestSource,
    Expression<bool>? hasUpdate,
    Expression<bool>? hasGap,
    Expression<String>? gapJson,
    Expression<DateTime>? checkedAt,
    Expression<bool>? notifyEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (pubStatus != null) 'pub_status': pubStatus,
      if (contentType != null) 'content_type': contentType,
      if (genres != null) 'genres': genres,
      if (totalChapters != null) 'total_chapters': totalChapters,
      if (source != null) 'source': source,
      if (sourceId != null) 'source_id': sourceId,
      if (mdxId != null) 'mdx_id': mdxId,
      if (lastReadChapter != null) 'last_read_chapter': lastReadChapter,
      if (latestChapter != null) 'latest_chapter': latestChapter,
      if (latestSource != null) 'latest_source': latestSource,
      if (hasUpdate != null) 'has_update': hasUpdate,
      if (hasGap != null) 'has_gap': hasGap,
      if (gapJson != null) 'gap_json': gapJson,
      if (checkedAt != null) 'checked_at': checkedAt,
      if (notifyEnabled != null) 'notify_enabled': notifyEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MangaTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? coverUrl,
      Value<String?>? author,
      Value<String?>? description,
      Value<String>? pubStatus,
      Value<String>? contentType,
      Value<String>? genres,
      Value<int?>? totalChapters,
      Value<String>? source,
      Value<String>? sourceId,
      Value<String?>? mdxId,
      Value<double>? lastReadChapter,
      Value<double?>? latestChapter,
      Value<String?>? latestSource,
      Value<bool>? hasUpdate,
      Value<bool>? hasGap,
      Value<String?>? gapJson,
      Value<DateTime?>? checkedAt,
      Value<bool>? notifyEnabled,
      Value<int>? rowid}) {
    return MangaTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      author: author ?? this.author,
      description: description ?? this.description,
      pubStatus: pubStatus ?? this.pubStatus,
      contentType: contentType ?? this.contentType,
      genres: genres ?? this.genres,
      totalChapters: totalChapters ?? this.totalChapters,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      mdxId: mdxId ?? this.mdxId,
      lastReadChapter: lastReadChapter ?? this.lastReadChapter,
      latestChapter: latestChapter ?? this.latestChapter,
      latestSource: latestSource ?? this.latestSource,
      hasUpdate: hasUpdate ?? this.hasUpdate,
      hasGap: hasGap ?? this.hasGap,
      gapJson: gapJson ?? this.gapJson,
      checkedAt: checkedAt ?? this.checkedAt,
      notifyEnabled: notifyEnabled ?? this.notifyEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (pubStatus.present) {
      map['pub_status'] = Variable<String>(pubStatus.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (genres.present) {
      map['genres'] = Variable<String>(genres.value);
    }
    if (totalChapters.present) {
      map['total_chapters'] = Variable<int>(totalChapters.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (mdxId.present) {
      map['mdx_id'] = Variable<String>(mdxId.value);
    }
    if (lastReadChapter.present) {
      map['last_read_chapter'] = Variable<double>(lastReadChapter.value);
    }
    if (latestChapter.present) {
      map['latest_chapter'] = Variable<double>(latestChapter.value);
    }
    if (latestSource.present) {
      map['latest_source'] = Variable<String>(latestSource.value);
    }
    if (hasUpdate.present) {
      map['has_update'] = Variable<bool>(hasUpdate.value);
    }
    if (hasGap.present) {
      map['has_gap'] = Variable<bool>(hasGap.value);
    }
    if (gapJson.present) {
      map['gap_json'] = Variable<String>(gapJson.value);
    }
    if (checkedAt.present) {
      map['checked_at'] = Variable<DateTime>(checkedAt.value);
    }
    if (notifyEnabled.present) {
      map['notify_enabled'] = Variable<bool>(notifyEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MangaTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('pubStatus: $pubStatus, ')
          ..write('contentType: $contentType, ')
          ..write('genres: $genres, ')
          ..write('totalChapters: $totalChapters, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('mdxId: $mdxId, ')
          ..write('lastReadChapter: $lastReadChapter, ')
          ..write('latestChapter: $latestChapter, ')
          ..write('latestSource: $latestSource, ')
          ..write('hasUpdate: $hasUpdate, ')
          ..write('hasGap: $hasGap, ')
          ..write('gapJson: $gapJson, ')
          ..write('checkedAt: $checkedAt, ')
          ..write('notifyEnabled: $notifyEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MangaTableTable mangaTable = $MangaTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mangaTable];
}

typedef $$MangaTableTableCreateCompanionBuilder = MangaTableCompanion Function({
  required String id,
  required String title,
  Value<String?> coverUrl,
  Value<String?> author,
  Value<String?> description,
  Value<String> pubStatus,
  Value<String> contentType,
  Value<String> genres,
  Value<int?> totalChapters,
  required String source,
  required String sourceId,
  Value<String?> mdxId,
  Value<double> lastReadChapter,
  Value<double?> latestChapter,
  Value<String?> latestSource,
  Value<bool> hasUpdate,
  Value<bool> hasGap,
  Value<String?> gapJson,
  Value<DateTime?> checkedAt,
  Value<bool> notifyEnabled,
  Value<int> rowid,
});
typedef $$MangaTableTableUpdateCompanionBuilder = MangaTableCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> coverUrl,
  Value<String?> author,
  Value<String?> description,
  Value<String> pubStatus,
  Value<String> contentType,
  Value<String> genres,
  Value<int?> totalChapters,
  Value<String> source,
  Value<String> sourceId,
  Value<String?> mdxId,
  Value<double> lastReadChapter,
  Value<double?> latestChapter,
  Value<String?> latestSource,
  Value<bool> hasUpdate,
  Value<bool> hasGap,
  Value<String?> gapJson,
  Value<DateTime?> checkedAt,
  Value<bool> notifyEnabled,
  Value<int> rowid,
});

class $$MangaTableTableFilterComposer
    extends Composer<_$AppDatabase, $MangaTableTable> {
  $$MangaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pubStatus => $composableBuilder(
      column: $table.pubStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genres => $composableBuilder(
      column: $table.genres, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalChapters => $composableBuilder(
      column: $table.totalChapters, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mdxId => $composableBuilder(
      column: $table.mdxId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lastReadChapter => $composableBuilder(
      column: $table.lastReadChapter,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latestChapter => $composableBuilder(
      column: $table.latestChapter, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get latestSource => $composableBuilder(
      column: $table.latestSource, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasUpdate => $composableBuilder(
      column: $table.hasUpdate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasGap => $composableBuilder(
      column: $table.hasGap, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gapJson => $composableBuilder(
      column: $table.gapJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get checkedAt => $composableBuilder(
      column: $table.checkedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notifyEnabled => $composableBuilder(
      column: $table.notifyEnabled, builder: (column) => ColumnFilters(column));
}

class $$MangaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MangaTableTable> {
  $$MangaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pubStatus => $composableBuilder(
      column: $table.pubStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genres => $composableBuilder(
      column: $table.genres, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalChapters => $composableBuilder(
      column: $table.totalChapters,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceId => $composableBuilder(
      column: $table.sourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mdxId => $composableBuilder(
      column: $table.mdxId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lastReadChapter => $composableBuilder(
      column: $table.lastReadChapter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latestChapter => $composableBuilder(
      column: $table.latestChapter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get latestSource => $composableBuilder(
      column: $table.latestSource,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasUpdate => $composableBuilder(
      column: $table.hasUpdate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasGap => $composableBuilder(
      column: $table.hasGap, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gapJson => $composableBuilder(
      column: $table.gapJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get checkedAt => $composableBuilder(
      column: $table.checkedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notifyEnabled => $composableBuilder(
      column: $table.notifyEnabled,
      builder: (column) => ColumnOrderings(column));
}

class $$MangaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MangaTableTable> {
  $$MangaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get pubStatus =>
      $composableBuilder(column: $table.pubStatus, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => column);

  GeneratedColumn<String> get genres =>
      $composableBuilder(column: $table.genres, builder: (column) => column);

  GeneratedColumn<int> get totalChapters => $composableBuilder(
      column: $table.totalChapters, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get mdxId =>
      $composableBuilder(column: $table.mdxId, builder: (column) => column);

  GeneratedColumn<double> get lastReadChapter => $composableBuilder(
      column: $table.lastReadChapter, builder: (column) => column);

  GeneratedColumn<double> get latestChapter => $composableBuilder(
      column: $table.latestChapter, builder: (column) => column);

  GeneratedColumn<String> get latestSource => $composableBuilder(
      column: $table.latestSource, builder: (column) => column);

  GeneratedColumn<bool> get hasUpdate =>
      $composableBuilder(column: $table.hasUpdate, builder: (column) => column);

  GeneratedColumn<bool> get hasGap =>
      $composableBuilder(column: $table.hasGap, builder: (column) => column);

  GeneratedColumn<String> get gapJson =>
      $composableBuilder(column: $table.gapJson, builder: (column) => column);

  GeneratedColumn<DateTime> get checkedAt =>
      $composableBuilder(column: $table.checkedAt, builder: (column) => column);

  GeneratedColumn<bool> get notifyEnabled => $composableBuilder(
      column: $table.notifyEnabled, builder: (column) => column);
}

class $$MangaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MangaTableTable,
    MangaTableData,
    $$MangaTableTableFilterComposer,
    $$MangaTableTableOrderingComposer,
    $$MangaTableTableAnnotationComposer,
    $$MangaTableTableCreateCompanionBuilder,
    $$MangaTableTableUpdateCompanionBuilder,
    (
      MangaTableData,
      BaseReferences<_$AppDatabase, $MangaTableTable, MangaTableData>
    ),
    MangaTableData,
    PrefetchHooks Function()> {
  $$MangaTableTableTableManager(_$AppDatabase db, $MangaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MangaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MangaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MangaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> coverUrl = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> pubStatus = const Value.absent(),
            Value<String> contentType = const Value.absent(),
            Value<String> genres = const Value.absent(),
            Value<int?> totalChapters = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> sourceId = const Value.absent(),
            Value<String?> mdxId = const Value.absent(),
            Value<double> lastReadChapter = const Value.absent(),
            Value<double?> latestChapter = const Value.absent(),
            Value<String?> latestSource = const Value.absent(),
            Value<bool> hasUpdate = const Value.absent(),
            Value<bool> hasGap = const Value.absent(),
            Value<String?> gapJson = const Value.absent(),
            Value<DateTime?> checkedAt = const Value.absent(),
            Value<bool> notifyEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MangaTableCompanion(
            id: id,
            title: title,
            coverUrl: coverUrl,
            author: author,
            description: description,
            pubStatus: pubStatus,
            contentType: contentType,
            genres: genres,
            totalChapters: totalChapters,
            source: source,
            sourceId: sourceId,
            mdxId: mdxId,
            lastReadChapter: lastReadChapter,
            latestChapter: latestChapter,
            latestSource: latestSource,
            hasUpdate: hasUpdate,
            hasGap: hasGap,
            gapJson: gapJson,
            checkedAt: checkedAt,
            notifyEnabled: notifyEnabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> coverUrl = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> pubStatus = const Value.absent(),
            Value<String> contentType = const Value.absent(),
            Value<String> genres = const Value.absent(),
            Value<int?> totalChapters = const Value.absent(),
            required String source,
            required String sourceId,
            Value<String?> mdxId = const Value.absent(),
            Value<double> lastReadChapter = const Value.absent(),
            Value<double?> latestChapter = const Value.absent(),
            Value<String?> latestSource = const Value.absent(),
            Value<bool> hasUpdate = const Value.absent(),
            Value<bool> hasGap = const Value.absent(),
            Value<String?> gapJson = const Value.absent(),
            Value<DateTime?> checkedAt = const Value.absent(),
            Value<bool> notifyEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MangaTableCompanion.insert(
            id: id,
            title: title,
            coverUrl: coverUrl,
            author: author,
            description: description,
            pubStatus: pubStatus,
            contentType: contentType,
            genres: genres,
            totalChapters: totalChapters,
            source: source,
            sourceId: sourceId,
            mdxId: mdxId,
            lastReadChapter: lastReadChapter,
            latestChapter: latestChapter,
            latestSource: latestSource,
            hasUpdate: hasUpdate,
            hasGap: hasGap,
            gapJson: gapJson,
            checkedAt: checkedAt,
            notifyEnabled: notifyEnabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MangaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MangaTableTable,
    MangaTableData,
    $$MangaTableTableFilterComposer,
    $$MangaTableTableOrderingComposer,
    $$MangaTableTableAnnotationComposer,
    $$MangaTableTableCreateCompanionBuilder,
    $$MangaTableTableUpdateCompanionBuilder,
    (
      MangaTableData,
      BaseReferences<_$AppDatabase, $MangaTableTable, MangaTableData>
    ),
    MangaTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MangaTableTableTableManager get mangaTable =>
      $$MangaTableTableTableManager(_db, _db.mangaTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localDbServiceHash() => r'23f8af1fef607a5bb6171c23789e51c33ee9ca11';

/// See also [localDbService].
@ProviderFor(localDbService)
final localDbServiceProvider = AutoDisposeProvider<LocalDbService>.internal(
  localDbService,
  name: r'localDbServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localDbServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalDbServiceRef = AutoDisposeProviderRef<LocalDbService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
