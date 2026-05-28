// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryStatsHash() => r'e54f93e96dc5ee21450b921a1b15fd38654096cf';

/// See also [libraryStats].
@ProviderFor(libraryStats)
final libraryStatsProvider = AutoDisposeProvider<LibraryStats>.internal(
  libraryStats,
  name: r'libraryStatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$libraryStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LibraryStatsRef = AutoDisposeProviderRef<LibraryStats>;
String _$libraryHash() => r'd6e3b9a1cc6f503dce42ef19a3f07b49e50dc0b7';

/// See also [Library].
@ProviderFor(Library)
final libraryProvider =
    AutoDisposeAsyncNotifierProvider<Library, List<Manga>>.internal(
  Library.new,
  name: r'libraryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$libraryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Library = AutoDisposeAsyncNotifier<List<Manga>>;
String _$isCheckingAllHash() => r'36b36073590604528808ef3e1ca85eb7aeabea92';

/// See also [IsCheckingAll].
@ProviderFor(IsCheckingAll)
final isCheckingAllProvider =
    AutoDisposeNotifierProvider<IsCheckingAll, bool>.internal(
  IsCheckingAll.new,
  name: r'isCheckingAllProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isCheckingAllHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsCheckingAll = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
