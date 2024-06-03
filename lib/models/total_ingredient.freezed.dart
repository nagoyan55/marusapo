// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'total_ingredient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TotalIngredient _$TotalIngredientFromJson(Map<String, dynamic> json) {
  return _TotalIngredient.fromJson(json);
}

/// @nodoc
mixin _$TotalIngredient {
  String get name => throw _privateConstructorUsedError;
  num get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TotalIngredientCopyWith<TotalIngredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotalIngredientCopyWith<$Res> {
  factory $TotalIngredientCopyWith(
          TotalIngredient value, $Res Function(TotalIngredient) then) =
      _$TotalIngredientCopyWithImpl<$Res, TotalIngredient>;
  @useResult
  $Res call({String name, num quantity, String unit});
}

/// @nodoc
class _$TotalIngredientCopyWithImpl<$Res, $Val extends TotalIngredient>
    implements $TotalIngredientCopyWith<$Res> {
  _$TotalIngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TotalIngredientImplCopyWith<$Res>
    implements $TotalIngredientCopyWith<$Res> {
  factory _$$TotalIngredientImplCopyWith(_$TotalIngredientImpl value,
          $Res Function(_$TotalIngredientImpl) then) =
      __$$TotalIngredientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, num quantity, String unit});
}

/// @nodoc
class __$$TotalIngredientImplCopyWithImpl<$Res>
    extends _$TotalIngredientCopyWithImpl<$Res, _$TotalIngredientImpl>
    implements _$$TotalIngredientImplCopyWith<$Res> {
  __$$TotalIngredientImplCopyWithImpl(
      _$TotalIngredientImpl _value, $Res Function(_$TotalIngredientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? unit = null,
  }) {
    return _then(_$TotalIngredientImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TotalIngredientImpl implements _TotalIngredient {
  const _$TotalIngredientImpl(
      {required this.name, required this.quantity, required this.unit});

  factory _$TotalIngredientImpl.fromJson(Map<String, dynamic> json) =>
      _$$TotalIngredientImplFromJson(json);

  @override
  final String name;
  @override
  final num quantity;
  @override
  final String unit;

  @override
  String toString() {
    return 'TotalIngredient(name: $name, quantity: $quantity, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TotalIngredientImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, quantity, unit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TotalIngredientImplCopyWith<_$TotalIngredientImpl> get copyWith =>
      __$$TotalIngredientImplCopyWithImpl<_$TotalIngredientImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TotalIngredientImplToJson(
      this,
    );
  }
}

abstract class _TotalIngredient implements TotalIngredient {
  const factory _TotalIngredient(
      {required final String name,
      required final num quantity,
      required final String unit}) = _$TotalIngredientImpl;

  factory _TotalIngredient.fromJson(Map<String, dynamic> json) =
      _$TotalIngredientImpl.fromJson;

  @override
  String get name;
  @override
  num get quantity;
  @override
  String get unit;
  @override
  @JsonKey(ignore: true)
  _$$TotalIngredientImplCopyWith<_$TotalIngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
