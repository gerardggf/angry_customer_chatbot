// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  bool get fetching => throw _privateConstructorUsedError;
  List<MessageModel> get messages => throw _privateConstructorUsedError;
  String get responseInstructions => throw _privateConstructorUsedError;
  AppLocale get responseLocale => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {bool fetching,
      List<MessageModel> messages,
      String responseInstructions,
      AppLocale responseLocale});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetching = null,
    Object? messages = null,
    Object? responseInstructions = null,
    Object? responseLocale = null,
  }) {
    return _then(_value.copyWith(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>,
      responseInstructions: null == responseInstructions
          ? _value.responseInstructions
          : responseInstructions // ignore: cast_nullable_to_non_nullable
              as String,
      responseLocale: null == responseLocale
          ? _value.responseLocale
          : responseLocale // ignore: cast_nullable_to_non_nullable
              as AppLocale,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool fetching,
      List<MessageModel> messages,
      String responseInstructions,
      AppLocale responseLocale});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetching = null,
    Object? messages = null,
    Object? responseInstructions = null,
    Object? responseLocale = null,
  }) {
    return _then(_$HomeStateImpl(
      fetching: null == fetching
          ? _value.fetching
          : fetching // ignore: cast_nullable_to_non_nullable
              as bool,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>,
      responseInstructions: null == responseInstructions
          ? _value.responseInstructions
          : responseInstructions // ignore: cast_nullable_to_non_nullable
              as String,
      responseLocale: null == responseLocale
          ? _value.responseLocale
          : responseLocale // ignore: cast_nullable_to_non_nullable
              as AppLocale,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  _$HomeStateImpl(
      {this.fetching = false,
      final List<MessageModel> messages = const [],
      this.responseInstructions = Global.responseInstructions,
      this.responseLocale = AppLocale.es})
      : _messages = messages;

  @override
  @JsonKey()
  final bool fetching;
  final List<MessageModel> _messages;
  @override
  @JsonKey()
  List<MessageModel> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final String responseInstructions;
  @override
  @JsonKey()
  final AppLocale responseLocale;

  @override
  String toString() {
    return 'HomeState(fetching: $fetching, messages: $messages, responseInstructions: $responseInstructions, responseLocale: $responseLocale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.fetching, fetching) ||
                other.fetching == fetching) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.responseInstructions, responseInstructions) ||
                other.responseInstructions == responseInstructions) &&
            (identical(other.responseLocale, responseLocale) ||
                other.responseLocale == responseLocale));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fetching,
      const DeepCollectionEquality().hash(_messages),
      responseInstructions,
      responseLocale);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
      {final bool fetching,
      final List<MessageModel> messages,
      final String responseInstructions,
      final AppLocale responseLocale}) = _$HomeStateImpl;

  @override
  bool get fetching;
  @override
  List<MessageModel> get messages;
  @override
  String get responseInstructions;
  @override
  AppLocale get responseLocale;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
