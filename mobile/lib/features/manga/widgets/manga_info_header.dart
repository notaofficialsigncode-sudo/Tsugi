import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/models/models.dart';

class MangaInfoHeader extends StatelessWidget {
  final Manga manga;
  final VoidCallback onCheckUpdate;

  const MangaInfoHeader({super.key, required this.manga, required this.onCheckUpdate});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // cover
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: manga.coverUrl != null && manga.coverUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: manga.coverUrl!,
                    width: 90, height: 126,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 90, height: 126,
                    color: cs.surfaceContainerHighest,
                    child: Center(
                      child: Text(
                        manga.title.substring(0, 2).toUpperCase(),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: cs.primary),
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 14),
          // info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(manga.title, style: Theme.of(context).textTheme.titleMedium, maxLines: 3, overflow: TextOverflow.ellipsis),
                if (manga.author != null) ...[
                  const SizedBox(height: 4),
                  Text(manga.author!, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                ],
                const SizedBox(height: 8),
                // status badges
                Wrap(
                  spacing: 6,
                  children: [
                    _badge(manga.pubStatus, cs.primaryContainer, cs.onPrimaryContainer),
                    _badge(manga.contentType, cs.secondaryContainer, cs.onSecondaryContainer),
                    _badge(manga.source, cs.surfaceContainerHighest, cs.onSurfaceVariant),
                  ],
                ),
                const SizedBox(height: 10),
                // action buttons
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: onCheckUpdate,
                        icon: const Icon(Icons.refresh_rounded, size: 16),
                        label: const Text('check update', style: TextStyle(fontSize: 12)),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_outline_rounded, size: 18),
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg)),
    );
  }
}
