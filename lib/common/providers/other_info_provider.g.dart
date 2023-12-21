// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getProfileByIdHash() => r'b72f2fcc7a2066a15aa678ff7df5518e0916e81e';

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

/// See also [getProfileById].
@ProviderFor(getProfileById)
const getProfileByIdProvider = GetProfileByIdFamily();

/// See also [getProfileById].
class GetProfileByIdFamily extends Family<AsyncValue<HttpResult>> {
  /// See also [getProfileById].
  const GetProfileByIdFamily();

  /// See also [getProfileById].
  GetProfileByIdProvider call(
    int userId,
  ) {
    return GetProfileByIdProvider(
      userId,
    );
  }

  @override
  GetProfileByIdProvider getProviderOverride(
    covariant GetProfileByIdProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'getProfileByIdProvider';
}

/// See also [getProfileById].
class GetProfileByIdProvider extends AutoDisposeFutureProvider<HttpResult> {
  /// See also [getProfileById].
  GetProfileByIdProvider(
    int userId,
  ) : this._internal(
          (ref) => getProfileById(
            ref as GetProfileByIdRef,
            userId,
          ),
          from: getProfileByIdProvider,
          name: r'getProfileByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProfileByIdHash,
          dependencies: GetProfileByIdFamily._dependencies,
          allTransitiveDependencies:
              GetProfileByIdFamily._allTransitiveDependencies,
          userId: userId,
        );

  GetProfileByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int userId;

  @override
  Override overrideWith(
    FutureOr<HttpResult> Function(GetProfileByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProfileByIdProvider._internal(
        (ref) => create(ref as GetProfileByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<HttpResult> createElement() {
    return _GetProfileByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProfileByIdProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetProfileByIdRef on AutoDisposeFutureProviderRef<HttpResult> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _GetProfileByIdProviderElement
    extends AutoDisposeFutureProviderElement<HttpResult>
    with GetProfileByIdRef {
  _GetProfileByIdProviderElement(super.provider);

  @override
  int get userId => (origin as GetProfileByIdProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
