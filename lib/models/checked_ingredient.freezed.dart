// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checked_ingredient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckedIngredient _$CheckedIngredientFromJson(Map<String, dynamic> json) {
  return _CheckedIngredient.fromJson(json);
}

/// @nodoc
mixin _$CheckedIngredient {
  String get name => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckedIngredientCopyWith<CheckedIngredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckedIngredientCopyWith<$Res> {
  factory $CheckedIngredientCopyWith(
          CheckedIngredient value, $Res Function(CheckedIngredient) then) =
      _$CheckedIngredientCopyWithImpl<$Res, CheckedIngredient>;
  @useResult
  $Res call({String name, bool isChecked});
}

/// @nodoc
class _$CheckedIngredientCopyWithImpl<$Res, $Val extends CheckedIngredient>
    implements $CheckedIngredientCopyWith<$Res> {
  _$CheckedIngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isChecked = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckedIngredientImplCopyWith<$Res>
    implements $CheckedIngredientCopyWith<$Res> {
  factory _$$CheckedIngredientImplCopyWith(_$CheckedIngredientImpl value,
          $Res Function(_$CheckedIngredientImpl) then) =
      __$$CheckedIngredientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, bool isChecked});
}

/// @nodoc
class __$$CheckedIngredientImplCopyWithImpl<$Res>
    extends _$CheckedIngredientCopyWithImpl<$Res, _$CheckedIngredientImpl>
    implements _$$CheckedIngredientImplCopyWith<$Res> {
  __$$CheckedIngredientImplCopyWithImpl(_$CheckedIngredientImpl _value,
      $Res Function(_$CheckedIngredientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isChecked = null,
  }) {
    return _then(_$CheckedIngredientImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckedIngredientImpl implements _CheckedIngredient {
  const _$CheckedIngredientImpl({required this.name, required this.isChecked});

  factory _$CheckedIngredientImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckedIngredientImplFromJson(json);

  @override
  final String name;
  @override
  final bool isChecked;

  @override
  String toString() {
    return 'CheckedIngredient(name: $name, isChecked: $isChecked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckedIngredientImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, isChecked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckedIngredientImplCopyWith<_$CheckedIngredientImpl> get copyWith =>
      __$$CheckedIngredientImplCopyWithImpl<_$CheckedIngredientImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckedIngredientImplToJson(
      this,
    );
  }
}

abstract class _CheckedIngredient implements CheckedIngredient {
  const factory _CheckedIngredient(
      {required final String name,
      required final bool isChecked}) = _$CheckedIngredientImpl;

  factory _CheckedIngredient.fromJson(Map<String, dynamic> json) =
      _$CheckedIngredientImpl.fromJson;

  @override
  String get name;
  @override
  bool get isChecked;
  @override
  @JsonKey(ignore: true)
  _$$CheckedIngredientImplCopyWith<_$CheckedIngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
