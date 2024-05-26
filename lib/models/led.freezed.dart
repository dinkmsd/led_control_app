// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'led.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Led _$LedFromJson(Map<String, dynamic> json) {
  return _Led.fromJson(json);
}

/// @nodoc
mixin _$Led {
  String get group => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  int? get temp => throw _privateConstructorUsedError;
  int? get humi => throw _privateConstructorUsedError;
  int? get brightness => throw _privateConstructorUsedError;
  String? get incli => throw _privateConstructorUsedError;
  String? get x => throw _privateConstructorUsedError;
  String? get y => throw _privateConstructorUsedError;
  String? get z => throw _privateConstructorUsedError;
  int? get rsrp => throw _privateConstructorUsedError;
  int? get cellID => throw _privateConstructorUsedError;
  List<History> get histories => throw _privateConstructorUsedError;
  List<Schedule> get schedules => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LedCopyWith<Led> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedCopyWith<$Res> {
  factory $LedCopyWith(Led value, $Res Function(Led) then) =
      _$LedCopyWithImpl<$Res, Led>;
  @useResult
  $Res call(
      {String group,
      String id,
      String name,
      bool status,
      double lat,
      double lon,
      int? temp,
      int? humi,
      int? brightness,
      String? incli,
      String? x,
      String? y,
      String? z,
      int? rsrp,
      int? cellID,
      List<History> histories,
      List<Schedule> schedules});
}

/// @nodoc
class _$LedCopyWithImpl<$Res, $Val extends Led> implements $LedCopyWith<$Res> {
  _$LedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? lat = null,
    Object? lon = null,
    Object? temp = freezed,
    Object? humi = freezed,
    Object? brightness = freezed,
    Object? incli = freezed,
    Object? x = freezed,
    Object? y = freezed,
    Object? z = freezed,
    Object? rsrp = freezed,
    Object? cellID = freezed,
    Object? histories = null,
    Object? schedules = null,
  }) {
    return _then(_value.copyWith(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int?,
      humi: freezed == humi
          ? _value.humi
          : humi // ignore: cast_nullable_to_non_nullable
              as int?,
      brightness: freezed == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as int?,
      incli: freezed == incli
          ? _value.incli
          : incli // ignore: cast_nullable_to_non_nullable
              as String?,
      x: freezed == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as String?,
      y: freezed == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as String?,
      z: freezed == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as String?,
      rsrp: freezed == rsrp
          ? _value.rsrp
          : rsrp // ignore: cast_nullable_to_non_nullable
              as int?,
      cellID: freezed == cellID
          ? _value.cellID
          : cellID // ignore: cast_nullable_to_non_nullable
              as int?,
      histories: null == histories
          ? _value.histories
          : histories // ignore: cast_nullable_to_non_nullable
              as List<History>,
      schedules: null == schedules
          ? _value.schedules
          : schedules // ignore: cast_nullable_to_non_nullable
              as List<Schedule>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LedImplCopyWith<$Res> implements $LedCopyWith<$Res> {
  factory _$$LedImplCopyWith(_$LedImpl value, $Res Function(_$LedImpl) then) =
      __$$LedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String group,
      String id,
      String name,
      bool status,
      double lat,
      double lon,
      int? temp,
      int? humi,
      int? brightness,
      String? incli,
      String? x,
      String? y,
      String? z,
      int? rsrp,
      int? cellID,
      List<History> histories,
      List<Schedule> schedules});
}

/// @nodoc
class __$$LedImplCopyWithImpl<$Res> extends _$LedCopyWithImpl<$Res, _$LedImpl>
    implements _$$LedImplCopyWith<$Res> {
  __$$LedImplCopyWithImpl(_$LedImpl _value, $Res Function(_$LedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? lat = null,
    Object? lon = null,
    Object? temp = freezed,
    Object? humi = freezed,
    Object? brightness = freezed,
    Object? incli = freezed,
    Object? x = freezed,
    Object? y = freezed,
    Object? z = freezed,
    Object? rsrp = freezed,
    Object? cellID = freezed,
    Object? histories = null,
    Object? schedules = null,
  }) {
    return _then(_$LedImpl(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      temp: freezed == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int?,
      humi: freezed == humi
          ? _value.humi
          : humi // ignore: cast_nullable_to_non_nullable
              as int?,
      brightness: freezed == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as int?,
      incli: freezed == incli
          ? _value.incli
          : incli // ignore: cast_nullable_to_non_nullable
              as String?,
      x: freezed == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as String?,
      y: freezed == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as String?,
      z: freezed == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as String?,
      rsrp: freezed == rsrp
          ? _value.rsrp
          : rsrp // ignore: cast_nullable_to_non_nullable
              as int?,
      cellID: freezed == cellID
          ? _value.cellID
          : cellID // ignore: cast_nullable_to_non_nullable
              as int?,
      histories: null == histories
          ? _value.histories
          : histories // ignore: cast_nullable_to_non_nullable
              as List<History>,
      schedules: null == schedules
          ? _value.schedules
          : schedules // ignore: cast_nullable_to_non_nullable
              as List<Schedule>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedImpl implements _Led {
  _$LedImpl(
      {required this.group,
      required this.id,
      required this.name,
      required this.status,
      required this.lat,
      required this.lon,
      this.temp,
      this.humi,
      this.brightness,
      this.incli,
      this.x,
      this.y,
      this.z,
      this.rsrp,
      this.cellID,
      this.histories = const [],
      this.schedules = const []});

  factory _$LedImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedImplFromJson(json);

  @override
  final String group;
  @override
  final String id;
  @override
  final String name;
  @override
  final bool status;
  @override
  final double lat;
  @override
  final double lon;
  @override
  final int? temp;
  @override
  final int? humi;
  @override
  final int? brightness;
  @override
  final String? incli;
  @override
  final String? x;
  @override
  final String? y;
  @override
  final String? z;
  @override
  final int? rsrp;
  @override
  final int? cellID;
  @override
  @JsonKey()
  final List<History> histories;
  @override
  @JsonKey()
  final List<Schedule> schedules;

  @override
  String toString() {
    return 'Led(group: $group, id: $id, name: $name, status: $status, lat: $lat, lon: $lon, temp: $temp, humi: $humi, brightness: $brightness, incli: $incli, x: $x, y: $y, z: $z, rsrp: $rsrp, cellID: $cellID, histories: $histories, schedules: $schedules)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedImpl &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.humi, humi) || other.humi == humi) &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.incli, incli) || other.incli == incli) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.rsrp, rsrp) || other.rsrp == rsrp) &&
            (identical(other.cellID, cellID) || other.cellID == cellID) &&
            const DeepCollectionEquality().equals(other.histories, histories) &&
            const DeepCollectionEquality().equals(other.schedules, schedules));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      group,
      id,
      name,
      status,
      lat,
      lon,
      temp,
      humi,
      brightness,
      incli,
      x,
      y,
      z,
      rsrp,
      cellID,
      const DeepCollectionEquality().hash(histories),
      const DeepCollectionEquality().hash(schedules));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LedImplCopyWith<_$LedImpl> get copyWith =>
      __$$LedImplCopyWithImpl<_$LedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedImplToJson(
      this,
    );
  }
}

abstract class _Led implements Led {
  factory _Led(
      {required final String group,
      required final String id,
      required final String name,
      required final bool status,
      required final double lat,
      required final double lon,
      final int? temp,
      final int? humi,
      final int? brightness,
      final String? incli,
      final String? x,
      final String? y,
      final String? z,
      final int? rsrp,
      final int? cellID,
      final List<History> histories,
      final List<Schedule> schedules}) = _$LedImpl;

  factory _Led.fromJson(Map<String, dynamic> json) = _$LedImpl.fromJson;

  @override
  String get group;
  @override
  String get id;
  @override
  String get name;
  @override
  bool get status;
  @override
  double get lat;
  @override
  double get lon;
  @override
  int? get temp;
  @override
  int? get humi;
  @override
  int? get brightness;
  @override
  String? get incli;
  @override
  String? get x;
  @override
  String? get y;
  @override
  String? get z;
  @override
  int? get rsrp;
  @override
  int? get cellID;
  @override
  List<History> get histories;
  @override
  List<Schedule> get schedules;
  @override
  @JsonKey(ignore: true)
  _$$LedImplCopyWith<_$LedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
