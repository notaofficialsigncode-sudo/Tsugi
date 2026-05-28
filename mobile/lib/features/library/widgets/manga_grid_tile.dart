import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/models/models.dart';
import '../../../core/theme/app_theme.dart';

class MangaGridTile extends StatelessWidget {
  final Manga manga;
  final VoidCallback onTap;

  const MangaGridTile({super.key, required this.manga, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      onLongPress: () => _showQuickActions(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // cover art
            _buildCover(context),

            // gradient overlay bottom
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(6, 24, 6, 5),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xE0000000), Colors.transparent],
                  ),
                ),
                child: Text(
                  manga.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ),
            ),

            // top-right badge: new chapter OR gap
            if (manga.hasGap)
              Positioned(
                top: 4, right: 4,
                child: _GapBadge(),
              )
            else if (manga.hasUpdate && manga.latestChapter != null)
              Positioned(
                top: 4, right: 4,
                child: _NewChapterBadge(chapter: manga.latestChapter!),
              ),

            // top-left: chapter number user is on
            if (manga.lastReadChapter > 0)
              Positioned(
                top: 4, left: 4,
                child: _ChapterNumBadge(chapter: manga.lastReadChapter),
              ),

            // content type pill (manhwa/manhua only — manga is default)
            if (manga.contentType != 'manga')
              Positioned(
                bottom: 28, left: 4,
                child: _TypePill(type: manga.contentType),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCover(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (manga.coverUrl != null && manga.coverUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: manga.coverUrl!,
        fit: BoxFit.cover,
        placeholder: (_, __) => _CoverPlaceholder(title: manga.title),
        errorWidget: (_, __, ___) => _CoverPlaceholder(title: manga.title),
      );
    }
    return _CoverPlaceholder(title: manga.title);
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => _QuickActionsSheet(manga: manga),
    );
  }
}

// ── Cover placeholder ───────────────────────────────────────────────
class _CoverPlaceholder extends StatelessWidget {
  final String title;
  const _CoverPlaceholder({required this.title});

  // deterministic color from title
  Color _bgColor() {
    final colors = [
      const Color(0xFF1A3A28),
      const Color(0xFF1A2A3A),
      const Color(0xFF2A1A3A),
      const Color(0xFF2A2A1A),
      const Color(0xFF3A1A1A),
      const Color(0xFF1A3A3A),
    ];
    return colors[title.codeUnitAt(0) % colors.length];
  }

  String _initials() {
    final words = title.trim().split(' ');
    if (words.length == 1) return title.substring(0, 2).toUpperCase();
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgColor(),
      child: Center(
        child: Text(
          _initials(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white54,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

// ── Badges ──────────────────────────────────────────────────────────
class _NewChapterBadge extends StatelessWidget {
  final double chapter;
  const _NewChapterBadge({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'ch.${chapter % 1 == 0 ? chapter.toInt() : chapter}',
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w700,
          color: Color(0xFF022C22),
        ),
      ),
    );
  }
}

class _GapBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFBBF24),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'GAP',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w700,
          color: Color(0xFF422006),
        ),
      ),
    );
  }
}

class _ChapterNumBadge extends StatelessWidget {
  final double chapter;
  const _ChapterNumBadge({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '${chapter % 1 == 0 ? chapter.toInt() : chapter}',
        style: const TextStyle(fontSize: 8, color: Colors.white70),
      ),
    );
  }
}

class _TypePill extends StatelessWidget {
  final String type;
  const _TypePill({required this.type});

  Color get _color => switch (type) {
    'manhwa' => const Color(0xFF5B8DEE),
    'manhua' => const Color(0xFFF59E0B),
    _ => const Color(0xFF10B981),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type,
        style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}

// ── Quick Actions ───────────────────────────────────────────────────
class _QuickActionsSheet extends StatelessWidget {
  final Manga manga;
  const _QuickActionsSheet({required this.manga});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(manga.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.refresh_rounded),
            title: const Text('check for updates'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.open_in_new_rounded),
            title: const Text('open on MangaDex'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(manga.notifyEnabled ? 'disable notifications' : 'enable notifications'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
            title: const Text('remove from library', style: TextStyle(color: Colors.redAccent)),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
