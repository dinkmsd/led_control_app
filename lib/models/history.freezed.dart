// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

History _$HistoryFromJson(Map<String, dynamic> json) {
  return _History.fromJson(json);
}

/// @nodoc
mixin _$History {
  int get temp => throw _privateConstructorUsedError;
  int get humi => throw _privateConstructorUsedError;
  int get brightness => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryCopyWith<History> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryCopyWith<$Res> {
  factory $HistoryCopyWith(History value, $Res Function(History) then) =
      _$HistoryCopyWithImpl<$Res, History>;
  @useResult
  $Res call({int temp, int humi, int brightness, DateTime dateTime});
}

/// @nodoc
class _$HistoryCopyWithImpl<$Res, $Val extends History>
    implements $HistoryCopyWith<$Res> {
  _$HistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? humi = null,
    Object? brightness = null,
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      humi: null == humi
          ? _value.humi
          : humi // ignore: cast_nullable_to_non_nullable
              as int,
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as int,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryImplCopyWith<$Res> implements $HistoryCopyWith<$Res> {
  factory _$$HistoryImplCopyWith(
          _$HistoryImpl value, $Res Function(_$HistoryImpl) then) =
      __$$HistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int temp, int humi, int brightness, DateTime dateTime});
}

/// @nodoc
class __$$HistoryImplCopyWithImpl<$Res>
    extends _$HistoryCopyWithImpl<$Res, _$HistoryImpl>
    implements _$$HistoryImplCopyWith<$Res> {
  __$$HistoryImplCopyWithImpl(
      _$HistoryImpl _value, $Res Function(_$HistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? humi = null,
    Object? brightness = null,
    Object? dateTime = null,
  }) {
    return _then(_$HistoryImpl(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      humi: null == humi
          ? _value.humi
          : humi // ignore: cast_nullable_to_non_nullable
              as int,
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as int,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryImpl implements _History {
  _$HistoryImpl(
      {required this.temp,
      required this.humi,
      required this.brightness,
      required this.dateTime});

  factory _$HistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryImplFromJson(json);

  @override
  final int temp;
  @override
  final int humi;
  @override
  final int brightness;
  @override
  final DateTime dateTime;

  @override
  String toString() {
    return 'History(temp: $temp, humi: $humi, brightness: $brightness, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryImpl &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.humi, humi) || other.humi == humi) &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, temp, humi, brightness, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryImplCopyWith<_$HistoryImpl> get copyWith =>
      __$$HistoryImplCopyWithImpl<_$HistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryImplToJson(
      this,
    );
  }
}

abstract class _History implements History {
  factory _History(
      {required final int temp,
      required final int humi,
      required final int brightness,
      required final DateTime dateTime}) = _$HistoryImpl;

  factory _History.fromJson(Map<String, dynamic> json) = _$HistoryImpl.fromJson;

  @override
  int get temp;
  @override
  int get humi;
  @override
  int get brightness;
  @override
  DateTime get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$HistoryImplCopyWith<_$HistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
