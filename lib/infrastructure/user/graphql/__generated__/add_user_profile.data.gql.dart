// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:user_app/infrastructure/__generated__/serializers.gql.dart'
    as _i1;

part 'add_user_profile.data.gql.g.dart';

abstract class GAddUserProfileData
    implements Built<GAddUserProfileData, GAddUserProfileDataBuilder> {
  GAddUserProfileData._();

  factory GAddUserProfileData(
      [Function(GAddUserProfileDataBuilder b) updates]) = _$GAddUserProfileData;

  static void _initializeBuilder(GAddUserProfileDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get addProfile;
  static Serializer<GAddUserProfileData> get serializer =>
      _$gAddUserProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAddUserProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAddUserProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAddUserProfileData.serializer,
        json,
      );
}
