// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SalesModel _$SalesModelFromJson(Map<String, dynamic> json) {
  return _SalesModel.fromJson(json);
}

/// @nodoc
mixin _$SalesModel {
  String? get sales_date => throw _privateConstructorUsedError;
  set sales_date(String? value) => throw _privateConstructorUsedError;
  String? get sales_id => throw _privateConstructorUsedError;
  set sales_id(String? value) => throw _privateConstructorUsedError;
  List<SalesProduct>? get sales_item => throw _privateConstructorUsedError;
  set sales_item(List<SalesProduct>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalesModelCopyWith<SalesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesModelCopyWith<$Res> {
  factory $SalesModelCopyWith(
          SalesModel value, $Res Function(SalesModel) then) =
      _$SalesModelCopyWithImpl<$Res, SalesModel>;
  @useResult
  $Res call(
      {String? sales_date, String? sales_id, List<SalesProduct>? sales_item});
}

/// @nodoc
class _$SalesModelCopyWithImpl<$Res, $Val extends SalesModel>
    implements $SalesModelCopyWith<$Res> {
  _$SalesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sales_date = freezed,
    Object? sales_id = freezed,
    Object? sales_item = freezed,
  }) {
    return _then(_value.copyWith(
      sales_date: freezed == sales_date
          ? _value.sales_date
          : sales_date // ignore: cast_nullable_to_non_nullable
              as String?,
      sales_id: freezed == sales_id
          ? _value.sales_id
          : sales_id // ignore: cast_nullable_to_non_nullable
              as String?,
      sales_item: freezed == sales_item
          ? _value.sales_item
          : sales_item // ignore: cast_nullable_to_non_nullable
              as List<SalesProduct>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesModelImplCopyWith<$Res>
    implements $SalesModelCopyWith<$Res> {
  factory _$$SalesModelImplCopyWith(
          _$SalesModelImpl value, $Res Function(_$SalesModelImpl) then) =
      __$$SalesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? sales_date, String? sales_id, List<SalesProduct>? sales_item});
}

/// @nodoc
class __$$SalesModelImplCopyWithImpl<$Res>
    extends _$SalesModelCopyWithImpl<$Res, _$SalesModelImpl>
    implements _$$SalesModelImplCopyWith<$Res> {
  __$$SalesModelImplCopyWithImpl(
      _$SalesModelImpl _value, $Res Function(_$SalesModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sales_date = freezed,
    Object? sales_id = freezed,
    Object? sales_item = freezed,
  }) {
    return _then(_$SalesModelImpl(
      sales_date: freezed == sales_date
          ? _value.sales_date
          : sales_date // ignore: cast_nullable_to_non_nullable
              as String?,
      sales_id: freezed == sales_id
          ? _value.sales_id
          : sales_id // ignore: cast_nullable_to_non_nullable
              as String?,
      sales_item: freezed == sales_item
          ? _value.sales_item
          : sales_item // ignore: cast_nullable_to_non_nullable
              as List<SalesProduct>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalesModelImpl implements _SalesModel {
  _$SalesModelImpl(
      {required this.sales_date,
      required this.sales_id,
      required this.sales_item});

  factory _$SalesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesModelImplFromJson(json);

  @override
  String? sales_date;
  @override
  String? sales_id;
  @override
  List<SalesProduct>? sales_item;

  @override
  String toString() {
    return 'SalesModel(sales_date: $sales_date, sales_id: $sales_id, sales_item: $sales_item)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesModelImplCopyWith<_$SalesModelImpl> get copyWith =>
      __$$SalesModelImplCopyWithImpl<_$SalesModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesModelImplToJson(
      this,
    );
  }
}

abstract class _SalesModel implements SalesModel {
  factory _SalesModel(
      {required String? sales_date,
      required String? sales_id,
      required List<SalesProduct>? sales_item}) = _$SalesModelImpl;

  factory _SalesModel.fromJson(Map<String, dynamic> json) =
      _$SalesModelImpl.fromJson;

  @override
  String? get sales_date;
  set sales_date(String? value);
  @override
  String? get sales_id;
  set sales_id(String? value);
  @override
  List<SalesProduct>? get sales_item;
  set sales_item(List<SalesProduct>? value);
  @override
  @JsonKey(ignore: true)
  _$$SalesModelImplCopyWith<_$SalesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
