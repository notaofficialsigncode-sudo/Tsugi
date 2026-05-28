import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

// ── Manga ──────────────────────────────────────────────────────────
@JsonSerializable()
class Manga {
  final String id;
  final String title;
  final String? coverUrl;
  final String? author;
  final String? description;
  final String pubStatus;       // ongoing | completed | hiatus | cancelled
  final String contentType;     // manga | manhwa | manhua
  final List<String> genres;
  final int? totalChapters;
  final String source;          // anilist | kitsu | mangaupdates | manual
  final String sourceId;
  final String? mdxId;          // MangaDex UUID
  final double lastReadChapter;
  final double? latestChapter;
  final String? latestSource;   // where the latest chapter was found
  final bool hasUpdate;
  final bool hasGap;
  final GapInfo? gap;
  final DateTime? checkedAt;
  final bool notifyEnabled;

  const Manga({
    required this.id,
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
    this.gap,
    this.checkedAt,
    required this.notifyEnabled,
  });

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);
  Map<String, dynamic> toJson() => _$MangaToJson(this);

  // how many chapters behind
  int get chaptersBehind {
    if (latestChapter == null) return 0;
    final diff = latestChapter! - lastReadChapter;
    return diff > 0 ? diff.floor() : 0;
  }

  // progress percentage
  double get progressPct {
    if (totalChapters == null || totalChapters == 0) return 0;
    return (lastReadChapter / totalChapters!).clamp(0.0, 1.0);
  }

  Manga copyWith({
    double? lastReadChapter,
    double? latestChapter,
    String? latestSource,
    bool? hasUpdate,
    bool? hasGap,
    GapInfo? gap,
    DateTime? checkedAt,
    bool? notifyEnabled,
  }) {
    return Manga(
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
      lastReadChapter: lastReadChapter ?? this.lastReadChapter,
      latestChapter: latestChapter ?? this.latestChapter,
      latestSource: latestSource ?? this.latestSource,
      hasUpdate: hasUpdate ?? this.hasUpdate,
      hasGap: hasGap ?? this.hasGap,
      gap: gap ?? this.gap,
      checkedAt: checkedAt ?? this.checkedAt,
      notifyEnabled: notifyEnabled ?? this.notifyEnabled,
    );
  }
}

// ── Gap Info ───────────────────────────────────────────────────────
@JsonSerializable()
class GapInfo {
  final double fromChapter;
  final double toChapter;
  final String? altSource;      // where the missing chapters were found
  final String? altSourceUrl;

  const GapInfo({
    required this.fromChapter,
    required this.toChapter,
    this.altSource,
    this.altSourceUrl,
  });

  int get missingCount => (toChapter - fromChapter).floor();

  factory GapInfo.fromJson(Map<String, dynamic> json) => _$GapInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GapInfoToJson(this);
}

// ── Chapter ────────────────────────────────────────────────────────
@JsonSerializable()
class Chapter {
  final String id;
  final String mangaId;
  final double number;
  final String? name;
  final String source;          // mangadex | toonily | asurascans | etc.
  final String sourceUrl;
  final String? scanlationGroup;
  final DateTime publishedAt;
  final bool isRead;
  final bool isGap;             // true = this is a placeholder for missing chapters

  const Chapter({
    required this.id,
    required this.mangaId,
    required this.number,
    this.name,
    required this.source,
    required this.sourceUrl,
    this.scanlationGroup,
    required this.publishedAt,
    required this.isRead,
    required this.isGap,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}

// ── Tracker Source ─────────────────────────────────────────────────
@JsonSerializable()
class TrackerAuth {
  final String source;         // anilist | kitsu | mangaupdates | shikimori | bangumi
  final String? username;
  final String? accessToken;
  final DateTime? lastSynced;
  final bool isConnected;
  final int syncedCount;

  const TrackerAuth({
    required this.source,
    this.username,
    this.accessToken,
    this.lastSynced,
    required this.isConnected,
    required this.syncedCount,
  });

  factory TrackerAuth.fromJson(Map<String, dynamic> json) => _$TrackerAuthFromJson(json);
  Map<String, dynamic> toJson() => _$TrackerAuthToJson(this);

  String get displayName => switch (source) {
    'anilist' => 'AniList',
    'kitsu' => 'Kitsu',
    'mangaupdates' => 'MangaUpdates',
    'shikimori' => 'Shikimori',
    'bangumi' => 'Bangumi',
    _ => source,
  };
}

// ── Update Feed Item ───────────────────────────────────────────────
@JsonSerializable()
class UpdateItem {
  final String mangaId;
  final String mangaTitle;
  final String? coverUrl;
  final double chapterNumber;
  final String? chapterName;
  final String source;
  final String? scanlationGroup;
  final DateTime releasedAt;
  final bool isGap;
  final GapInfo? gapInfo;

  const UpdateItem({
    required this.mangaId,
    required this.mangaTitle,
    this.coverUrl,
    required this.chapterNumber,
    this.chapterName,
    required this.source,
    this.scanlationGroup,
    required this.releasedAt,
    required this.isGap,
    this.gapInfo,
  });

  factory UpdateItem.fromJson(Map<String, dynamic> json) => _$UpdateItemFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateItemToJson(this);
}
