// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_schedule_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$employeeScheduleVmHash() =>
    r'e7db5c61bc2ae779e6ff6713404218c59a863979';

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

abstract class _$EmployeeScheduleVm
    extends BuildlessAutoDisposeAsyncNotifier<List<ScheduleModel>> {
  late final DateTime date;
  late final int userId;

  FutureOr<List<ScheduleModel>> build(
    DateTime date,
    int userId,
  );
}

/// See also [EmployeeScheduleVm].
@ProviderFor(EmployeeScheduleVm)
const employeeScheduleVmProvider = EmployeeScheduleVmFamily();

/// See also [EmployeeScheduleVm].
class EmployeeScheduleVmFamily extends Family<AsyncValue<List<ScheduleModel>>> {
  /// See also [EmployeeScheduleVm].
  const EmployeeScheduleVmFamily();

  /// See also [EmployeeScheduleVm].
  EmployeeScheduleVmProvider call(
    DateTime date,
    int userId,
  ) {
    return EmployeeScheduleVmProvider(
      date,
      userId,
    );
  }

  @override
  EmployeeScheduleVmProvider getProviderOverride(
    covariant EmployeeScheduleVmProvider provider,
  ) {
    return call(
      provider.date,
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
  String? get name => r'employeeScheduleVmProvider';
}

/// See also [EmployeeScheduleVm].
class EmployeeScheduleVmProvider extends AutoDisposeAsyncNotifierProviderImpl<
    EmployeeScheduleVm, List<ScheduleModel>> {
  /// See also [EmployeeScheduleVm].
  EmployeeScheduleVmProvider(
    DateTime date,
    int userId,
  ) : this._internal(
          () => EmployeeScheduleVm()
            ..date = date
            ..userId = userId,
          from: employeeScheduleVmProvider,
          name: r'employeeScheduleVmProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$employeeScheduleVmHash,
          dependencies: EmployeeScheduleVmFamily._dependencies,
          allTransitiveDependencies:
              EmployeeScheduleVmFamily._allTransitiveDependencies,
          date: date,
          userId: userId,
        );

  EmployeeScheduleVmProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
    required this.userId,
  }) : super.internal();

  final DateTime date;
  final int userId;

  @override
  FutureOr<List<ScheduleModel>> runNotifierBuild(
    covariant EmployeeScheduleVm notifier,
  ) {
    return notifier.build(
      date,
      userId,
    );
  }

  @override
  Override overrideWith(EmployeeScheduleVm Function() create) {
    return ProviderOverride(
      origin: this,
      override: EmployeeScheduleVmProvider._internal(
        () => create()
          ..date = date
          ..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EmployeeScheduleVm,
      List<ScheduleModel>> createElement() {
    return _EmployeeScheduleVmProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeScheduleVmProvider &&
        other.date == date &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EmployeeScheduleVmRef
    on AutoDisposeAsyncNotifierProviderRef<List<ScheduleModel>> {
  /// The parameter `date` of this provider.
  DateTime get date;

  /// The parameter `userId` of this provider.
  int get userId;
}

class _EmployeeScheduleVmProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EmployeeScheduleVm,
        List<ScheduleModel>> with EmployeeScheduleVmRef {
  _EmployeeScheduleVmProviderElement(super.provider);

  @override
  DateTime get date => (origin as EmployeeScheduleVmProvider).date;
  @override
  int get userId => (origin as EmployeeScheduleVmProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
