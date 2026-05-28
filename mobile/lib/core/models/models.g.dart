// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manga _$MangaFromJson(Map<String, dynamic> json) => Manga(
      id: json['id'] as String,
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      pubStatus: json['pubStatus'] as String,
      contentType: json['contentType'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      totalChapters: (json['totalChapters'] as num?)?.toInt(),
      source: json['source'] as String,
      sourceId: json['sourceId'] as String,
      mdxId: json['mdxId'] as String?,
      lastReadChapter: (json['lastReadChapter'] as num).toDouble(),
      latestChapter: (json['latestChapter'] as num?)?.toDouble(),
      latestSource: json['latestSource'] as String?,
      hasUpdate: json['hasUpdate'] as bool,
      hasGap: json['hasGap'] as bool,
      gap: json['gap'] == null
          ? null
          : GapInfo.fromJson(json['gap'] as Map<String, dynamic>),
      checkedAt: json['checkedAt'] == null
          ? null
          : DateTime.parse(json['checkedAt'] as String),
      notifyEnabled: json['notifyEnabled'] as bool,
    );

Map<String, dynamic> _$MangaToJson(Manga instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coverUrl': instance.coverUrl,
      'author': instance.author,
      'description': instance.description,
      'pubStatus': instance.pubStatus,
      'contentType': instance.contentType,
      'genres': instance.genres,
      'totalChapters': instance.totalChapters,
      'source': instance.source,
      'sourceId': instance.sourceId,
      'mdxId': instance.mdxId,
      'lastReadChapter': instance.lastReadChapter,
      'latestChapter': instance.latestChapter,
      'latestSource': instance.latestSource,
      'hasUpdate': instance.hasUpdate,
      'hasGap': instance.hasGap,
      'gap': instance.gap,
      'checkedAt': instance.checkedAt?.toIso8601String(),
      'notifyEnabled': instance.notifyEnabled,
    };

GapInfo _$GapInfoFromJson(Map<String, dynamic> json) => GapInfo(
      fromChapter: (json['fromChapter'] as num).toDouble(),
      toChapter: (json['toChapter'] as num).toDouble(),
      altSource: json['altSource'] as String?,
      altSourceUrl: json['altSourceUrl'] as String?,
    );

Map<String, dynamic> _$GapInfoToJson(GapInfo instance) => <String, dynamic>{
      'fromChapter': instance.fromChapter,
      'toChapter': instance.toChapter,
      'altSource': instance.altSource,
      'altSourceUrl': instance.altSourceUrl,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      id: json['id'] as String,
      mangaId: json['mangaId'] as String,
      number: (json['number'] as num).toDouble(),
      name: json['name'] as String?,
      source: json['source'] as String,
      sourceUrl: json['sourceUrl'] as String,
      scanlationGroup: json['scanlationGroup'] as String?,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      isRead: json['isRead'] as bool,
      isGap: json['isGap'] as bool,
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'id': instance.id,
      'mangaId': instance.mangaId,
      'number': instance.number,
      'name': instance.name,
      'source': instance.source,
      'sourceUrl': instance.sourceUrl,
      'scanlationGroup': instance.scanlationGroup,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'isRead': instance.isRead,
      'isGap': instance.isGap,
    };

TrackerAuth _$TrackerAuthFromJson(Map<String, dynamic> json) => TrackerAuth(
      source: json['source'] as String,
      username: json['username'] as String?,
      accessToken: json['accessToken'] as String?,
      lastSynced: json['lastSynced'] == null
          ? null
          : DateTime.parse(json['lastSynced'] as String),
      isConnected: json['isConnected'] as bool,
      syncedCount: (json['syncedCount'] as num).toInt(),
    );

Map<String, dynamic> _$TrackerAuthToJson(TrackerAuth instance) =>
    <String, dynamic>{
      'source': instance.source,
      'username': instance.username,
      'accessToken': instance.accessToken,
      'lastSynced': instance.lastSynced?.toIso8601String(),
      'isConnected': instance.isConnected,
      'syncedCount': instance.syncedCount,
    };

UpdateItem _$UpdateItemFromJson(Map<String, dynamic> json) => UpdateItem(
      mangaId: json['mangaId'] as String,
      mangaTitle: json['mangaTitle'] as String,
      coverUrl: json['coverUrl'] as String?,
      chapterNumber: (json['chapterNumber'] as num).toDouble(),
      chapterName: json['chapterName'] as String?,
      source: json['source'] as String,
      scanlationGroup: json['scanlationGroup'] as String?,
      releasedAt: DateTime.parse(json['releasedAt'] as String),
      isGap: json['isGap'] as bool,
      gapInfo: json['gapInfo'] == null
          ? null
          : GapInfo.fromJson(json['gapInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateItemToJson(UpdateItem instance) =>
    <String, dynamic>{
      'mangaId': instance.mangaId,
      'mangaTitle': instance.mangaTitle,
      'coverUrl': instance.coverUrl,
      'chapterNumber': instance.chapterNumber,
      'chapterName': instance.chapterName,
      'source': instance.source,
      'scanlationGroup': instance.scanlationGroup,
      'releasedAt': instance.releasedAt.toIso8601String(),
      'isGap': instance.isGap,
      'gapInfo': instance.gapInfo,
    };
