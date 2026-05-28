// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manga _$MangaFromJson(Map<String, dynamic> json) => Manga(
      id: json['id'] as String,
      title: json['title'] as String,
      coverUrl: json['cover_url'] as String?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      pubStatus: json['pub_status'] as String,
      contentType: json['content_type'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      totalChapters: (json['total_chapters'] as num?)?.toInt(),
      source: json['source'] as String,
      sourceId: json['source_id'] as String,
      mdxId: json['mdx_id'] as String?,
      lastReadChapter: (json['last_read'] as num).toDouble(),
      latestChapter: (json['latest_chapter'] as num?)?.toDouble(),
      latestSource: json['latest_source'] as String?,
      hasUpdate: json['has_update'] as bool,
      hasGap: json['has_gap'] as bool,
      checkedAt: json['checked_at'] == null
          ? null
          : DateTime.parse(json['checked_at'] as String),
      notifyEnabled: json['notify'] as bool,
    );

Map<String, dynamic> _$MangaToJson(Manga instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover_url': instance.coverUrl,
      'author': instance.author,
      'description': instance.description,
      'pub_status': instance.pubStatus,
      'content_type': instance.contentType,
      'genres': instance.genres,
      'total_chapters': instance.totalChapters,
      'source': instance.source,
      'source_id': instance.sourceId,
      'mdx_id': instance.mdxId,
      'last_read': instance.lastReadChapter,
      'latest_chapter': instance.latestChapter,
      'latest_source': instance.latestSource,
      'has_update': instance.hasUpdate,
      'has_gap': instance.hasGap,
      'checked_at': instance.checkedAt?.toIso8601String(),
      'notify': instance.notifyEnabled,
    };

GapInfo _$GapInfoFromJson(Map<String, dynamic> json) => GapInfo(
      fromChapter: (json['from_chapter'] as num).toDouble(),
      toChapter: (json['to_chapter'] as num).toDouble(),
      altSource: json['alt_source'] as String?,
      altSourceUrl: json['alt_source_url'] as String?,
    );

Map<String, dynamic> _$GapInfoToJson(GapInfo instance) => <String, dynamic>{
      'from_chapter': instance.fromChapter,
      'to_chapter': instance.toChapter,
      'alt_source': instance.altSource,
      'alt_source_url': instance.altSourceUrl,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      id: json['id'] as String,
      mangaId: json['manga_id'] as String,
      number: (json['number'] as num).toDouble(),
      name: json['name'] as String?,
      source: json['source'] as String,
      sourceUrl: json['source_url'] as String,
      scanlationGroup: json['scanlation_group'] as String?,
      publishedAt: DateTime.parse(json['published_at'] as String),
      isRead: json['is_read'] as bool,
      isGap: json['is_gap'] as bool,
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'id': instance.id,
      'manga_id': instance.mangaId,
      'number': instance.number,
      'name': instance.name,
      'source': instance.source,
      'source_url': instance.sourceUrl,
      'scanlation_group': instance.scanlationGroup,
      'published_at': instance.publishedAt.toIso8601String(),
      'is_read': instance.isRead,
      'is_gap': instance.isGap,
    };

TrackerAuth _$TrackerAuthFromJson(Map<String, dynamic> json) => TrackerAuth(
      source: json['source'] as String,
      username: json['username'] as String?,
      accessToken: json['access_token'] as String?,
      lastSynced: json['last_synced'] == null
          ? null
          : DateTime.parse(json['last_synced'] as String),
      isConnected: json['is_connected'] as bool,
      syncedCount: (json['synced_count'] as num).toInt(),
    );

Map<String, dynamic> _$TrackerAuthToJson(TrackerAuth instance) =>
    <String, dynamic>{
      'source': instance.source,
      'username': instance.username,
      'access_token': instance.accessToken,
      'last_synced': instance.lastSynced?.toIso8601String(),
      'is_connected': instance.isConnected,
      'synced_count': instance.syncedCount,
    };

UpdateItem _$UpdateItemFromJson(Map<String, dynamic> json) => UpdateItem(
      mangaId: json['manga_id'] as String,
      mangaTitle: json['manga_title'] as String,
      coverUrl: json['cover_url'] as String?,
      chapterNumber: (json['chapter_number'] as num).toDouble(),
      chapterName: json['chapter_name'] as String?,
      source: json['source'] as String,
      scanlationGroup: json['scanlation_group'] as String?,
      releasedAt: DateTime.parse(json['released_at'] as String),
      isGap: json['is_gap'] as bool,
    );

Map<String, dynamic> _$UpdateItemToJson(UpdateItem instance) =>
    <String, dynamic>{
      'manga_id': instance.mangaId,
      'manga_title': instance.mangaTitle,
      'cover_url': instance.coverUrl,
      'chapter_number': instance.chapterNumber,
      'chapter_name': instance.chapterName,
      'source': instance.source,
      'scanlation_group': instance.scanlationGroup,
      'released_at': instance.releasedAt.toIso8601String(),
      'is_gap': instance.isGap,
    };
