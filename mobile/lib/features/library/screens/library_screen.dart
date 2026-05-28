import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/models.dart';
import '../../../core/router/app_router.dart';
import '../providers/library_provider.dart';
import '../widgets/manga_grid_tile.dart';
import '../widgets/library_app_bar.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  static const _categories = [
    _Cat('all', null),
    _Cat('reading', 'reading'),
    _Cat('manga', 'manga'),
    _Cat('manhwa', 'manhwa'),
    _Cat('manhua', 'manhua'),
    _Cat('completed', 'completed'),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final libraryAsync = ref.watch(libraryProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          LibraryAppBar(
            innerBoxIsScrolled: innerBoxIsScrolled,
            onSearch: () => context.push('/search'),
            onFilter: () => _showFilterSheet(context),
            onCheckAll: () => ref.read(libraryProvider.notifier).checkAllUpdates(),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabs,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: cs.primary,
                unselectedLabelColor: cs.onSurfaceVariant,
                indicatorColor: cs.primary,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.white.withValues(alpha: 0.07),
                tabs: _categories.map((c) {
                  final count = libraryAsync.valueOrNull
                      ?.where((m) => c.filter == null ||
                          m.contentType == c.filter ||
                          m.pubStatus == c.filter)
                      .length;
                  return Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(c.label, style: const TextStyle(fontSize: 13)),
                        if (count != null && count > 0) ...[
                          const SizedBox(width: 5),
                          _CountBadge(count: count),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
        body: libraryAsync.when(
          loading: () => _buildShimmerGrid(),
          error: (e, _) => _buildError(e),
          data: (manga) => TabBarView(
            controller: _tabs,
            children: _categories.map((c) {
              final filtered = c.filter == null
                  ? manga
                  : manga
                      .where((m) =>
                          m.contentType == c.filter || m.pubStatus == c.filter)
                      .toList();
              return _MangaGrid(
                items: filtered,
                onTap: (m) => context.push(AppRoutes.mangaDetail(m.id)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 2 / 3,
      ),
      itemCount: 12,
      itemBuilder: (_, __) => const _ShimmerTile(),
    );
  }

  Widget _buildError(Object e) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline_rounded, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          Text('failed to load library\n$e', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.tonal(
            onPressed: () => ref.invalidate(libraryProvider),
            child: const Text('retry'),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => const _FilterSheet(),
    );
  }
}

// ── Grid ────────────────────────────────────────────────────────────
class _MangaGrid extends StatelessWidget {
  final List<Manga> items;
  final void Function(Manga) onTap;

  const _MangaGrid({required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.library_books_outlined,
                size: 56, color: Theme.of(context).colorScheme.surfaceContainerHighest),
            const SizedBox(height: 12),
            Text('nothing here yet',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 90),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 2 / 3,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) => MangaGridTile(
        manga: items[i],
        onTap: () => onTap(items[i]),
      ),
    );
  }
}

// ── Manga Grid Tile ─────────────────────────────────────────────────
class _ShimmerTile extends StatelessWidget {
  const _ShimmerTile();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// ── Count badge ─────────────────────────────────────────────────────
class _CountBadge extends StatelessWidget {
  final int count;
  const _CountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$count',
        style: TextStyle(fontSize: 10, color: cs.onPrimaryContainer, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ── Tab bar delegate ────────────────────────────────────────────────
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  const _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate old) => false;
}

// ── Filter Sheet ────────────────────────────────────────────────────
class _FilterSheet extends StatelessWidget {
  const _FilterSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.viewInsetsOf(context).bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('filter & sort', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Text('sort by', style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: ['title', 'last updated', 'chapters behind', 'added']
                .map((s) => FilterChip(label: Text(s), onSelected: (_) {}, selected: s == 'last updated'))
                .toList(),
          ),
          const SizedBox(height: 16),
          Text('show only', style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: ['has updates', 'has gaps', 'completed', 'hiatus']
                .map((s) => FilterChip(label: Text(s), onSelected: (_) {}, selected: false))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Cat {
  final String label;
  final String? filter;
  const _Cat(this.label, this.filter);
}
