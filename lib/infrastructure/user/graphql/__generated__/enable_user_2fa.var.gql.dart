// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:user_app/infrastructure/__generated__/serializers.gql.dart'
    as _i1;

part 'enable_user_2fa.var.gql.g.dart';

abstract class GTurnOn2FAVars
    implements Built<GTurnOn2FAVars, GTurnOn2FAVarsBuilder> {
  GTurnOn2FAVars._();

  factory GTurnOn2FAVars([Function(GTurnOn2FAVarsBuilder b) updates]) =
      _$GTurnOn2FAVars;

  String get code;
  static Serializer<GTurnOn2FAVars> get serializer =>
      _$gTurnOn2FAVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GTurnOn2FAVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GTurnOn2FAVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GTurnOn2FAVars.serializer,
        json,
      );
}
