import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/models.dart';
import '../providers/manga_detail_provider.dart';
import '../widgets/chapter_table.dart';
import '../widgets/gap_alert_banner.dart';
import '../widgets/manga_info_header.dart';
import '../../library/providers/library_provider.dart';

class MangaDetailScreen extends ConsumerWidget {
  final String mangaId;
  const MangaDetailScreen({super.key, required this.mangaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(mangaDetailProvider(mangaId));
    final chaptersAsync = ref.watch(chapterListProvider(mangaId));
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('error: $e')),
        data: (manga) => CustomScrollView(
          slivers: [
            // ── App bar with cover blur ──────────────────────────
            _DetailAppBar(manga: manga),

            // ── Hero section: cover + info ───────────────────────
            SliverToBoxAdapter(
              child: MangaInfoHeader(
                manga: manga,
                onCheckUpdate: () =>
                    ref.read(libraryProvider.notifier).checkSingle(mangaId),
              ),
            ),

            // ── Tags ─────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _TagsSection(genres: manga.genres, contentType: manga.contentType),
            ),

            // ── Description ──────────────────────────────────────
            if (manga.description != null)
              SliverToBoxAdapter(
                child: _DescriptionSection(description: manga.description!),
              ),

            // ── Progress box ─────────────────────────────────────
            SliverToBoxAdapter(
              child: _ProgressBox(manga: manga),
            ),

            // ── Gap alert ────────────────────────────────────────
            if (manga.hasGap && manga.gap != null)
              SliverToBoxAdapter(
                child: GapAlertBanner(gap: manga.gap!),
              ),

            // ── Chapter list header ───────────────────────────────
            SliverToBoxAdapter(
              child: _ChapterListHeader(manga: manga),
            ),

            // ── Chapter table ────────────────────────────────────
            chaptersAsync.when(
              loading: () => const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: Center(child: Text('failed to load chapters: $e')),
              ),
              data: (chapters) => ChapterTable(
                chapters: chapters,
                onMarkRead: (ch) => ref
                    .read(libraryProvider.notifier)
                    .updateProgress(mangaId, ch.number),
                onOpenSource: (ch) => launchUrl(Uri.parse(ch.sourceUrl)),
              ),
            ),

            const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
          ],
        ),
      ),
    );
  }
}

// ── App bar ─────────────────────────────────────────────────────────
class _DetailAppBar extends StatelessWidget {
  final Manga manga;
  const _DetailAppBar({required this.manga});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0,
      pinned: true,
      title: Text(
        manga.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        IconButton(icon: const Icon(Icons.share_rounded), onPressed: () {}),
        IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
      ],
    );
  }
}

// ── Tags section ────────────────────────────────────────────────────
class _TagsSection extends StatelessWidget {
  final List<String> genres;
  final String contentType;
  const _TagsSection({required this.genres, required this.contentType});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          // content type always first
          _buildTag(context, contentType, isPrimary: true),
          ...genres.map((g) => _buildTag(context, g)),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String label, {bool isPrimary = false}) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary
            ? cs.primaryContainer.withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPrimary
              ? cs.primary.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: isPrimary ? cs.primary : cs.onSurfaceVariant,
          fontWeight: isPrimary ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }
}

// ── Description ─────────────────────────────────────────────────────
class _DescriptionSection extends StatefulWidget {
  final String description;
  const _DescriptionSection({required this.description});

  @override
  State<_DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<_DescriptionSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            firstChild: Text(
              widget.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, height: 1.6),
            ),
            secondChild: Text(
              widget.description,
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, height: 1.6),
            ),
            crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _expanded ? 'less' : 'more',
                style: TextStyle(fontSize: 12, color: cs.primary, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Progress box ────────────────────────────────────────────────────
class _ProgressBox extends StatelessWidget {
  final Manga manga;
  const _ProgressBox({required this.manga});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final behind = manga.chaptersBehind;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 0.5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('last read chapter', style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                Text(
                  'ch. ${manga.lastReadChapter % 1 == 0 ? manga.lastReadChapter.toInt() : manga.lastReadChapter}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: cs.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: manga.progressPct,
                backgroundColor: Colors.white.withValues(alpha: 0.08),
                valueColor: AlwaysStoppedAnimation(cs.primary),
                minHeight: 3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('latest released', style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                Row(
                  children: [
                    if (manga.latestChapter != null) ...[
                      Text(
                        'ch. ${manga.latestChapter!.toInt()}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: behind > 0 ? const Color(0xFFFBBF24) : cs.onSurface,
                        ),
                      ),
                      if (behind > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBBF24).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$behind behind',
                            style: const TextStyle(fontSize: 10, color: Color(0xFFFBBF24)),
                          ),
                        ),
                      ],
                    ] else
                      Text('not checked', style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Chapter list header ─────────────────────────────────────────────
class _ChapterListHeader extends StatelessWidget {
  final Manga manga;
  const _ChapterListHeader({required this.manga});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      child: Row(
        children: [
          Text(
            manga.totalChapters != null
                ? '${manga.totalChapters} chapters'
                : 'chapters',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: cs.onSurfaceVariant),
          ),
          const Spacer(),
          // filter chips
          _FilterChip(label: 'all', selected: true),
          const SizedBox(width: 6),
          _FilterChip(label: 'unread', selected: false),
          const SizedBox(width: 6),
          _FilterChip(label: 'gaps', selected: false),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? cs.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? cs.primary.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.12),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: selected ? cs.primary : cs.onSurfaceVariant,
          fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }
}
