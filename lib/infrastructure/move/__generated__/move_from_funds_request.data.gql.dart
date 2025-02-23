// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:user_app/infrastructure/__generated__/serializers.gql.dart'
    as _i1;

part 'move_from_funds_request.data.gql.g.dart';

abstract class GMoveFromAdvancedTradingFundsData
    implements
        Built<GMoveFromAdvancedTradingFundsData,
            GMoveFromAdvancedTradingFundsDataBuilder> {
  GMoveFromAdvancedTradingFundsData._();

  factory GMoveFromAdvancedTradingFundsData(
          [Function(GMoveFromAdvancedTradingFundsDataBuilder b) updates]) =
      _$GMoveFromAdvancedTradingFundsData;

  static void _initializeBuilder(GMoveFromAdvancedTradingFundsDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get moveFromAdvancedTrading;
  static Serializer<GMoveFromAdvancedTradingFundsData> get serializer =>
      _$gMoveFromAdvancedTradingFundsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMoveFromAdvancedTradingFundsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMoveFromAdvancedTradingFundsData? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMoveFromAdvancedTradingFundsData.serializer,
        json,
      );
}
