// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class AllLifts$Query$Lift with EquatableMixin {
  AllLifts$Query$Lift();

  factory AllLifts$Query$Lift.fromJson(Map<String, dynamic> json) =>
      _$AllLifts$Query$LiftFromJson(json);

  String id;

  String name;

  @JsonKey(unknownEnumValue: LiftStatus.artemisUnknown)
  LiftStatus status;

  @override
  List<Object> get props => [id, name, status];
  Map<String, dynamic> toJson() => _$AllLifts$Query$LiftToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AllLifts$Query with EquatableMixin {
  AllLifts$Query();

  factory AllLifts$Query.fromJson(Map<String, dynamic> json) =>
      _$AllLifts$QueryFromJson(json);

  List<AllLifts$Query$Lift> allLifts;

  @override
  List<Object> get props => [allLifts];
  Map<String, dynamic> toJson() => _$AllLifts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SetStatus$Mutation$Lift with EquatableMixin {
  SetStatus$Mutation$Lift();

  factory SetStatus$Mutation$Lift.fromJson(Map<String, dynamic> json) =>
      _$SetStatus$Mutation$LiftFromJson(json);

  String id;

  String name;

  @JsonKey(unknownEnumValue: LiftStatus.artemisUnknown)
  LiftStatus status;

  int capacity;

  @override
  List<Object> get props => [id, name, status, capacity];
  Map<String, dynamic> toJson() => _$SetStatus$Mutation$LiftToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SetStatus$Mutation with EquatableMixin {
  SetStatus$Mutation();

  factory SetStatus$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SetStatus$MutationFromJson(json);

  SetStatus$Mutation$Lift setLiftStatus;

  @override
  List<Object> get props => [setLiftStatus];
  Map<String, dynamic> toJson() => _$SetStatus$MutationToJson(this);
}

enum LiftStatus {
  @JsonValue('OPEN')
  open,
  @JsonValue('CLOSED')
  closed,
  @JsonValue('HOLD')
  hold,
  @JsonValue('ARTEMIS_UNKNOWN')
  artemisUnknown,
}

class AllLiftsQuery extends GraphQLQuery<AllLifts$Query, JsonSerializable> {
  AllLiftsQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'allLifts'),
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'allLifts'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'status'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'allLifts';

  @override
  List<Object> get props => [document, operationName];
  @override
  AllLifts$Query parse(Map<String, dynamic> json) =>
      AllLifts$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SetStatusArguments extends JsonSerializable with EquatableMixin {
  SetStatusArguments({@required this.id, @required this.status});

  @override
  factory SetStatusArguments.fromJson(Map<String, dynamic> json) =>
      _$SetStatusArgumentsFromJson(json);

  final String id;

  @JsonKey(unknownEnumValue: LiftStatus.artemisUnknown)
  final LiftStatus status;

  @override
  List<Object> get props => [id, status];
  @override
  Map<String, dynamic> toJson() => _$SetStatusArgumentsToJson(this);
}

class SetStatusMutation
    extends GraphQLQuery<SetStatus$Mutation, SetStatusArguments> {
  SetStatusMutation({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.mutation,
        name: NameNode(value: 'setStatus'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'id')),
              type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: []),
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'status')),
              type: NamedTypeNode(
                  name: NameNode(value: 'LiftStatus'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'setLiftStatus'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'id'),
                    value: VariableNode(name: NameNode(value: 'id'))),
                ArgumentNode(
                    name: NameNode(value: 'status'),
                    value: VariableNode(name: NameNode(value: 'status')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'status'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'capacity'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'setStatus';

  @override
  final SetStatusArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  SetStatus$Mutation parse(Map<String, dynamic> json) =>
      SetStatus$Mutation.fromJson(json);
}
