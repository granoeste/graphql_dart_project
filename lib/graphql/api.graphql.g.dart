// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllLifts$Query$Lift _$AllLifts$Query$LiftFromJson(Map<String, dynamic> json) {
  return AllLifts$Query$Lift()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..status = _$enumDecodeNullable(_$LiftStatusEnumMap, json['status'],
        unknownValue: LiftStatus.artemisUnknown);
}

Map<String, dynamic> _$AllLifts$Query$LiftToJson(
        AllLifts$Query$Lift instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$LiftStatusEnumMap[instance.status],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$LiftStatusEnumMap = {
  LiftStatus.open: 'OPEN',
  LiftStatus.closed: 'CLOSED',
  LiftStatus.hold: 'HOLD',
  LiftStatus.artemisUnknown: 'ARTEMIS_UNKNOWN',
};

AllLifts$Query _$AllLifts$QueryFromJson(Map<String, dynamic> json) {
  return AllLifts$Query()
    ..allLifts = (json['allLifts'] as List)
        ?.map((e) => e == null
            ? null
            : AllLifts$Query$Lift.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AllLifts$QueryToJson(AllLifts$Query instance) =>
    <String, dynamic>{
      'allLifts': instance.allLifts?.map((e) => e?.toJson())?.toList(),
    };

SetStatus$Mutation$Lift _$SetStatus$Mutation$LiftFromJson(
    Map<String, dynamic> json) {
  return SetStatus$Mutation$Lift()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..status = _$enumDecodeNullable(_$LiftStatusEnumMap, json['status'],
        unknownValue: LiftStatus.artemisUnknown)
    ..capacity = json['capacity'] as int;
}

Map<String, dynamic> _$SetStatus$Mutation$LiftToJson(
        SetStatus$Mutation$Lift instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$LiftStatusEnumMap[instance.status],
      'capacity': instance.capacity,
    };

SetStatus$Mutation _$SetStatus$MutationFromJson(Map<String, dynamic> json) {
  return SetStatus$Mutation()
    ..setLiftStatus = json['setLiftStatus'] == null
        ? null
        : SetStatus$Mutation$Lift.fromJson(
            json['setLiftStatus'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SetStatus$MutationToJson(SetStatus$Mutation instance) =>
    <String, dynamic>{
      'setLiftStatus': instance.setLiftStatus?.toJson(),
    };

SetStatusArguments _$SetStatusArgumentsFromJson(Map<String, dynamic> json) {
  return SetStatusArguments(
    id: json['id'] as String,
    status: _$enumDecodeNullable(_$LiftStatusEnumMap, json['status'],
        unknownValue: LiftStatus.artemisUnknown),
  );
}

Map<String, dynamic> _$SetStatusArgumentsToJson(SetStatusArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$LiftStatusEnumMap[instance.status],
    };
