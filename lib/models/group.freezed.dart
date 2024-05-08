// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  String get id => throw _privateConstructorUsedError;
  int get numLeds => throw _privateConstructorUsedError;
  int get ledActive => throw _privateConstructorUsedError;
  int get ledError => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;
  List<Led> get leds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call(
      {String id,
      int numLeds,
      int ledActive,
      int ledError,
      String groupName,
      bool status,
      List<Led> leds});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? numLeds = null,
    Object? ledActive = null,
    Object? ledError = null,
    Object? groupName = null,
    Object? status = null,
    Object? leds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      numLeds: null == numLeds
          ? _value.numLeds
          : numLeds // ignore: cast_nullable_to_non_nullable
              as int,
      ledActive: null == ledActive
          ? _value.ledActive
          : ledActive // ignore: cast_nullable_to_non_nullable
              as int,
      ledError: null == ledError
          ? _value.ledError
          : ledError // ignore: cast_nullable_to_non_nullable
              as int,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      leds: null == leds
          ? _value.leds
          : leds // ignore: cast_nullable_to_non_nullable
              as List<Led>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
          _$GroupImpl value, $Res Function(_$GroupImpl) then) =
      __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int numLeds,
      int ledActive,
      int ledError,
      String groupName,
      bool status,
      List<Led> leds});
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$GroupCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
      _$GroupImpl _value, $Res Function(_$GroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? numLeds = null,
    Object? ledActive = null,
    Object? ledError = null,
    Object? groupName = null,
    Object? status = null,
    Object? leds = null,
  }) {
    return _then(_$GroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      numLeds: null == numLeds
          ? _value.numLeds
          : numLeds // ignore: cast_nullable_to_non_nullable
              as int,
      ledActive: null == ledActive
          ? _value.ledActive
          : ledActive // ignore: cast_nullable_to_non_nullable
              as int,
      ledError: null == ledError
          ? _value.ledError
          : ledError // ignore: cast_nullable_to_non_nullable
              as int,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      leds: null == leds
          ? _value.leds
          : leds // ignore: cast_nullable_to_non_nullable
              as List<Led>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupImpl implements _Group {
  _$GroupImpl(
      {required this.id,
      required this.numLeds,
      required this.ledActive,
      required this.ledError,
      required this.groupName,
      required this.status,
      this.leds = const []});

  factory _$GroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupImplFromJson(json);

  @override
  final String id;
  @override
  final int numLeds;
  @override
  final int ledActive;
  @override
  final int ledError;
  @override
  final String groupName;
  @override
  final bool status;
  @override
  @JsonKey()
  final List<Led> leds;

  @override
  String toString() {
    return 'Group(id: $id, numLeds: $numLeds, ledActive: $ledActive, ledError: $ledError, groupName: $groupName, status: $status, leds: $leds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.numLeds, numLeds) || other.numLeds == numLeds) &&
            (identical(other.ledActive, ledActive) ||
                other.ledActive == ledActive) &&
            (identical(other.ledError, ledError) ||
                other.ledError == ledError) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.leds, leds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, numLeds, ledActive, ledError,
      groupName, status, const DeepCollectionEquality().hash(leds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupImplToJson(
      this,
    );
  }
}

abstract class _Group implements Group {
  factory _Group(
      {required final String id,
      required final int numLeds,
      required final int ledActive,
      required final int ledError,
      required final String groupName,
      required final bool status,
      final List<Led> leds}) = _$GroupImpl;

  factory _Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  @override
  String get id;
  @override
  int get numLeds;
  @override
  int get ledActive;
  @override
  int get ledError;
  @override
  String get groupName;
  @override
  bool get status;
  @override
  List<Led> get leds;
  @override
  @JsonKey(ignore: true)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
