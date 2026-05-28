import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/models.dart';

class ChapterTable extends StatelessWidget {
  final List<Chapter> chapters;
  final void Function(Chapter) onMarkRead;
  final void Function(Chapter) onOpenSource;

  const ChapterTable({
    super.key,
    required this.chapters,
    required this.onMarkRead,
    required this.onOpenSource,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: chapters.length,
      separatorBuilder: (_, __) => Divider(
        height: 0,
        thickness: 0.5,
        color: Colors.white.withValues(alpha: 0.05),
      ),
      itemBuilder: (context, i) {
        final ch = chapters[i];
        if (ch.isGap) return _GapRow(chapter: ch);
        return _ChapterRow(
          no: i + 1,
          chapter: ch,
          onMarkRead: () => onMarkRead(ch),
          onOpenSource: () => onOpenSource(ch),
        );
      },
    );
  }
}

// ── Normal chapter row ──────────────────────────────────────────────
class _ChapterRow extends StatelessWidget {
  final int no;
  final Chapter chapter;
  final VoidCallback onMarkRead;
  final VoidCallback onOpenSource;

  const _ChapterRow({
    required this.no,
    required this.chapter,
    required this.onMarkRead,
    required this.onOpenSource,
  });

  Color _sourcePillColor(String source) => switch (source.toLowerCase()) {
    'mangadex' => const Color(0xFF10B981),
    'toonily' || 'manhwatop' || 'manhwazone' => const Color(0xFF5B8DEE),
    'bilibili' || 'coolmic' => const Color(0xFFFBBF24),
    'webtoon' || 'webtoons' => const Color(0xFF34D399),
    'asurascans' || 'asura scans' => const Color(0xFFA78BFA),
    _ => const Color(0xFF6B7280),
  };

  String _sourceLabel(String source) => switch (source.toLowerCase()) {
    'mangadex' => 'MDX',
    'toonily' => 'Toonily',
    'bilibili' => 'Bilibili',
    'webtoon' || 'webtoons' => 'Webtoon',
    'asurascans' || 'asura scans' => 'Asura',
    'flamescans' || 'flame scans' || 'flame comics' => 'Flame',
    'hivescans' || 'hive scans' => 'Hive',
    'zeroscans' || 'zero scans' => 'Zero',
    'cubari' => 'Cubari',
    _ => source.length > 8 ? '${source.substring(0, 8)}..' : source,
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isUnread = !chapter.isRead;
    final sourceColor = _sourcePillColor(chapter.source);

    return InkWell(
      onTap: onOpenSource,
      onLongPress: () => _showChapterActions(context),
      child: Container(
        color: isUnread ? cs.primary.withValues(alpha: 0.03) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            // No.
            SizedBox(
              width: 28,
              child: Text(
                '$no',
                style: TextStyle(
                  fontSize: 11,
                  color: isUnread ? cs.onSurfaceVariant : cs.onSurface.withValues(alpha: 0.25),
                ),
              ),
            ),

            // Source pill
            SizedBox(
              width: 64,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: sourceColor.withValues(alpha: isUnread ? 0.15 : 0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _sourceLabel(chapter.source),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isUnread ? sourceColor : sourceColor.withValues(alpha: 0.4),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Chapter name
            Expanded(
              child: Row(
                children: [
                  if (isUnread)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      chapter.name ?? 'chapter ${chapter.number % 1 == 0 ? chapter.number.toInt() : chapter.number}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isUnread ? cs.onSurface : cs.onSurface.withValues(alpha: 0.3),
                        fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Chapter number
            Text(
              '${chapter.number % 1 == 0 ? chapter.number.toInt() : chapter.number}',
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: isUnread ? cs.onSurface : cs.onSurface.withValues(alpha: 0.25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChapterActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'chapter ${chapter.number}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(height: 0),
            ListTile(
              leading: const Icon(Icons.check_rounded),
              title: const Text('mark as read'),
              onTap: () { Navigator.pop(context); onMarkRead(); },
            ),
            ListTile(
              leading: const Icon(Icons.open_in_new_rounded),
              title: Text('open on ${chapter.source}'),
              onTap: () { Navigator.pop(context); onOpenSource(); },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ── Gap row ─────────────────────────────────────────────────────────
class _GapRow extends StatelessWidget {
  final Chapter chapter;
  const _GapRow({required this.chapter});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const amber = Color(0xFFFBBF24);

    return InkWell(
      onTap: chapter.sourceUrl.isNotEmpty
          ? () => launchUrl(Uri.parse(chapter.sourceUrl))
          : null,
      child: Container(
        color: amber.withValues(alpha: 0.05),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            // warning icon instead of number
            const SizedBox(
              width: 28,
              child: Icon(Icons.warning_amber_rounded, size: 14, color: amber),
            ),

            // source pill
            SizedBox(
              width: 64,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: amber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: amber.withValues(alpha: 0.25), width: 0.5),
                ),
                child: Text(
                  chapter.source.isEmpty ? 'gap' : chapter.source,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: amber),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // gap info
            Expanded(
              child: Text(
                chapter.name ?? 'missing chapters',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFDE68A),
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(width: 8),

            // chapter range
            Text(
              '${chapter.number.toInt()}',
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: amber,
              ),
            ),

            if (chapter.sourceUrl.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(Icons.arrow_outward_rounded, size: 12, color: amber),
              ),
          ],
        ),
      ),
    );
  }
}
