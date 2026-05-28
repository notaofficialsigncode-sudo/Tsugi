// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mangaDetailHash() => r'81004d8af735b99c7d05f72a9cf7710f7e7cfab7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [mangaDetail].
@ProviderFor(mangaDetail)
const mangaDetailProvider = MangaDetailFamily();

/// See also [mangaDetail].
class MangaDetailFamily extends Family<AsyncValue<Manga>> {
  /// See also [mangaDetail].
  const MangaDetailFamily();

  /// See also [mangaDetail].
  MangaDetailProvider call(
    String mangaId,
  ) {
    return MangaDetailProvider(
      mangaId,
    );
  }

  @override
  MangaDetailProvider getProviderOverride(
    covariant MangaDetailProvider provider,
  ) {
    return call(
      provider.mangaId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mangaDetailProvider';
}

/// See also [mangaDetail].
class MangaDetailProvider extends AutoDisposeFutureProvider<Manga> {
  /// See also [mangaDetail].
  MangaDetailProvider(
    String mangaId,
  ) : this._internal(
          (ref) => mangaDetail(
            ref as MangaDetailRef,
            mangaId,
          ),
          from: mangaDetailProvider,
          name: r'mangaDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mangaDetailHash,
          dependencies: MangaDetailFamily._dependencies,
          allTransitiveDependencies:
              MangaDetailFamily._allTransitiveDependencies,
          mangaId: mangaId,
        );

  MangaDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mangaId,
  }) : super.internal();

  final String mangaId;

  @override
  Override overrideWith(
    FutureOr<Manga> Function(MangaDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MangaDetailProvider._internal(
        (ref) => create(ref as MangaDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mangaId: mangaId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Manga> createElement() {
    return _MangaDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MangaDetailProvider && other.mangaId == mangaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mangaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MangaDetailRef on AutoDisposeFutureProviderRef<Manga> {
  /// The parameter `mangaId` of this provider.
  String get mangaId;
}

class _MangaDetailProviderElement
    extends AutoDisposeFutureProviderElement<Manga> with MangaDetailRef {
  _MangaDetailProviderElement(super.provider);

  @override
  String get mangaId => (origin as MangaDetailProvider).mangaId;
}

String _$chapterListHash() => r'3e8e59f4e97e7efaea85faf299569906a69fef1c';

/// See also [chapterList].
@ProviderFor(chapterList)
const chapterListProvider = ChapterListFamily();

/// See also [chapterList].
class ChapterListFamily extends Family<AsyncValue<List<Chapter>>> {
  /// See also [chapterList].
  const ChapterListFamily();

  /// See also [chapterList].
  ChapterListProvider call(
    String mangaId,
  ) {
    return ChapterListProvider(
      mangaId,
    );
  }

  @override
  ChapterListProvider getProviderOverride(
    covariant ChapterListProvider provider,
  ) {
    return call(
      provider.mangaId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chapterListProvider';
}

/// See also [chapterList].
class ChapterListProvider extends AutoDisposeFutureProvider<List<Chapter>> {
  /// See also [chapterList].
  ChapterListProvider(
    String mangaId,
  ) : this._internal(
          (ref) => chapterList(
            ref as ChapterListRef,
            mangaId,
          ),
          from: chapterListProvider,
          name: r'chapterListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chapterListHash,
          dependencies: ChapterListFamily._dependencies,
          allTransitiveDependencies:
              ChapterListFamily._allTransitiveDependencies,
          mangaId: mangaId,
        );

  ChapterListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mangaId,
  }) : super.internal();

  final String mangaId;

  @override
  Override overrideWith(
    FutureOr<List<Chapter>> Function(ChapterListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChapterListProvider._internal(
        (ref) => create(ref as ChapterListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mangaId: mangaId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Chapter>> createElement() {
    return _ChapterListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChapterListProvider && other.mangaId == mangaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mangaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChapterListRef on AutoDisposeFutureProviderRef<List<Chapter>> {
  /// The parameter `mangaId` of this provider.
  String get mangaId;
}

class _ChapterListProviderElement
    extends AutoDisposeFutureProviderElement<List<Chapter>>
    with ChapterListRef {
  _ChapterListProviderElement(super.provider);

  @override
  String get mangaId => (origin as ChapterListProvider).mangaId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
