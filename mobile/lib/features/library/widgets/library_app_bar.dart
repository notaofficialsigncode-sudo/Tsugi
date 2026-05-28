import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/library_provider.dart';

class LibraryAppBar extends ConsumerWidget {
  final bool innerBoxIsScrolled;
  final VoidCallback onSearch;
  final VoidCallback onFilter;
  final VoidCallback onCheckAll;

  const LibraryAppBar({
    super.key,
    required this.innerBoxIsScrolled,
    required this.onSearch,
    required this.onFilter,
    required this.onCheckAll,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final isChecking = ref.watch(isCheckingAllProvider);
    final stats = ref.watch(libraryStatsProvider);

    return SliverAppBar(
      floating: true,
      snap: true,
      forceElevated: innerBoxIsScrolled,
      title: Row(
        children: [
          // tsugi. logo
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
              ),
              children: [
                TextSpan(text: 'tsugi', style: TextStyle(color: cs.onSurface)),
                TextSpan(text: '.', style: TextStyle(color: cs.primary, fontSize: 26)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // update count pill
          if (stats.updates > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${stats.updates} new',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
        ],
      ),
      actions: [
        // check all updates button
        IconButton(
          onPressed: isChecking ? null : onCheckAll,
          tooltip: 'check all updates',
          icon: isChecking
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: cs.primary,
                  ),
                )
              : const Icon(Icons.refresh_rounded),
        ),
        IconButton(
          onPressed: onSearch,
          tooltip: 'search library',
          icon: const Icon(Icons.search_rounded),
        ),
        IconButton(
          onPressed: onFilter,
          tooltip: 'filter',
          icon: const Icon(Icons.filter_list_rounded),
        ),
      ],
    );
  }
}
