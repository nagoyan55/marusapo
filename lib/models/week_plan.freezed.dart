// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'week_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeekPlan _$WeekPlanFromJson(Map<String, dynamic> json) {
  return _WeekPlan.fromJson(json);
}

/// @nodoc
mixin _$WeekPlan {
  List<DayPlan> get days => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeekPlanCopyWith<WeekPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeekPlanCopyWith<$Res> {
  factory $WeekPlanCopyWith(WeekPlan value, $Res Function(WeekPlan) then) =
      _$WeekPlanCopyWithImpl<$Res, WeekPlan>;
  @useResult
  $Res call({List<DayPlan> days});
}

/// @nodoc
class _$WeekPlanCopyWithImpl<$Res, $Val extends WeekPlan>
    implements $WeekPlanCopyWith<$Res> {
  _$WeekPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
  }) {
    return _then(_value.copyWith(
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<DayPlan>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeekPlanImplCopyWith<$Res>
    implements $WeekPlanCopyWith<$Res> {
  factory _$$WeekPlanImplCopyWith(
          _$WeekPlanImpl value, $Res Function(_$WeekPlanImpl) then) =
      __$$WeekPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DayPlan> days});
}

/// @nodoc
class __$$WeekPlanImplCopyWithImpl<$Res>
    extends _$WeekPlanCopyWithImpl<$Res, _$WeekPlanImpl>
    implements _$$WeekPlanImplCopyWith<$Res> {
  __$$WeekPlanImplCopyWithImpl(
      _$WeekPlanImpl _value, $Res Function(_$WeekPlanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
  }) {
    return _then(_$WeekPlanImpl(
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<DayPlan>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeekPlanImpl implements _WeekPlan {
  const _$WeekPlanImpl({required final List<DayPlan> days}) : _days = days;

  factory _$WeekPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeekPlanImplFromJson(json);

  final List<DayPlan> _days;
  @override
  List<DayPlan> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  String toString() {
    return 'WeekPlan(days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeekPlanImpl &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_days));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeekPlanImplCopyWith<_$WeekPlanImpl> get copyWith =>
      __$$WeekPlanImplCopyWithImpl<_$WeekPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeekPlanImplToJson(
      this,
    );
  }
}

abstract class _WeekPlan implements WeekPlan {
  const factory _WeekPlan({required final List<DayPlan> days}) = _$WeekPlanImpl;

  factory _WeekPlan.fromJson(Map<String, dynamic> json) =
      _$WeekPlanImpl.fromJson;

  @override
  List<DayPlan> get days;
  @override
  @JsonKey(ignore: true)
  _$$WeekPlanImplCopyWith<_$WeekPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
