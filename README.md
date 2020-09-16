# GraphQL for Dart

## Introduction
GraphQL は、Facebook が開発している Web API のための仕様。スキーマ定義とクエリー言語から成り立つ。
スキーマ定義は、GraphQL の API 仕様を定義する。
クエリー言語は、オペレーションを行うためのもので、データ取得系の Query、データ更新系の Mutation、サーバーイベントの通知の Subscription の3種類がある。
GraphQL では、スキーマ定義に対してクエリー言語を通じてリクエストを行う。

OpenAPI では、データを増やす場合、エンドポイントのレスポンスの構造体に項目が増えたり、エンドポイントが分けて同じようなレスポンスの構造体がふえたりして、スキーマ定義が冗長化する傾向にあるが、GraphQL は、クエリーを通して必要なデータののみ取得や更新を行うことができる。

GraphQL のライブラリは [Apollo](https://www.apollographql.com/) が有名であるが、Dart/Flutter はサポートされていないため、[graphql](https://pub.dev/packages/graphql), [graphql_flutter](https://pub.dev/packages/graphql_flutter) を使用することになる。

GitHub は API v4 で GraphQLを採用している。 [GitHub GraphQL API v4](https:/developer.github.com/v4/)
GitHub GraphQL API は、データ取得系の Query を試すには良いが、データ更新系の Mutation を試すのには向いていない。また、スキーマ定義はかなり巨大で構造を理解するのには向いていない。
Playground - https://snowtooth.moonhighway.com/ や [graphql-faker](https://github.com/APIs-guru/graphql-faker) を使用した方が理解しやすい。

詳しくは [GraphQL](https://graphql.org/)や[「GraphQL」徹底入門 ─ RESTとの比較、API・フロント双方の実装から学ぶ](https://employment.en-japan.com/engineerhub/entry/2018/12/26/103000) を参照

--- 
次より、
GraphQL Client の [graphql](https://pub.dev/packages/graphql) と、GraphQL Schemas and Queries Code Generator の [artemis](https://pub.dev/packages/artemis) で、GraphQL API Server の Playground - https://snowtooth.moonhighway.com/ にアクセスする手順を記載する。

## Download Schema

CLI ツールの [get-graphql-schema](https://github.com/prisma-labs/get-graphql-schema) を使用する

### Insall
```sh
npm install -g get-graphql-schema
```

### Get Schema
```sh
get-graphql-schema http://snowtooth.moonhighway.com/ > schema.graphql
```

#### Result (excerpt)
```graphql
"""
A `Lift` is a chairlift, gondola, tram, funicular, pulley, rope tow, or other means of ascending a mountain.
"""
type Lift {
 """The unique identifier for a `Lift` (id: "panorama")"""
 id: ID!
 
 """The name of a `Lift`"""
 name: String!
 
 """The current status for a `Lift`: `OPEN`, `CLOSED`, `HOLD`"""
 status: LiftStatus
 
 """The number of people that a `Lift` can hold"""
 capacity: Int!
 
 """A boolean describing whether a `Lift` is open for night skiing"""
 night: Boolean!
 
 """The number of feet in elevation that a `Lift` ascends"""
 elevationGain: Int!
 
 """A list of trails that this `Lift` serves"""
 trailAccess: [Trail!]!
}
 
"""
An enum describing the options for `LiftStatus`: `OPEN`, `CLOSED`, `HOLD`
"""
enum LiftStatus {
 OPEN
 CLOSED
 HOLD
}
 
type Mutation {
 """Sets a `Lift` status by sending `id` and `status`"""
 setLiftStatus(id: ID!, status: LiftStatus!): Lift!
}
 
type Query {
 """A list of all `Lift` objects"""
 allLifts(status: LiftStatus): [Lift!]!
 
 """Returns a `Lift` by `id` (id: "panorama")"""
 Lift(id: ID!): Lift!
}
 
type Subscription {
 """Listens for changes in lift status"""
 liftStatusChange: Lift
}
 
"""The `Upload` scalar type represents a file upload."""
scalar Upload
```

## Code Generate

### Setup Project

#### Install Stagehand
*Stagehand is a Dart project generator

```sh
pub global activate stagehand
```

#### Generate Dart Project

```sh
mkdir graphql_project
cd graphql_project
stagehand package-simple
```

#### Setup Dependencies
GraphQL Client [graphql](https://pub.dev/packages/graphql) の追加
```yaml
dependencies:
 graphql: ^4.0.0-alpha.3
```

GraphQL Schemas and Queries Code Generator [artemis](https://pub.dev/packages/artemis) と関連 Package の追加
```yaml
dev_dependencies:
 build_runner: ^1.10.2
 json_serializable: ^3.4.1
 artemis: ^6.12.3-beta.1
```

- [build_runner](https://pub.dev/packages/build_runner) ... ジェネレーターのランナー
- [json_serializable](https://pub.dev/packages/json_serializable) ... JSON をシリアライズ/デシリアライするコードのジェネレーター

Dependencies の更新
```
pub get
```

### Artemis

build.yaml をプロジェクトディレクトリのルートに作成

```yaml
targets:
  $default:
    sources:
      - lib/**
      - graphql/**
      - schema.graphql
    builders:
      artemis:
        options:
          schema_mapping:
            - schema: schema.graphql
              queries_glob: graphql/*.graphql
              output: lib/graphql/api.dart
```

ダウンロードした スキーマファイル(schema.graphql)をプロジェクトディレクトリにコピー

.graphqlconfig をルート作成
```yaml
{
  "name": "Schema",
  "schemaPath": "schema.graphql",
  "extensions": {
    "endpoints": {
      "Default": {
        "url": "http://snowtooth.moonhighway.com",
        "introspect": true
      }
    }
  }
}
```
このファイルがあると VSCode, Android Studio のプラグインでクエリーを検証することができる。


#### Query (データ取得) クエリーファイルの作成

graphql/query_allLifts.graphql
```graphql
query allLifts {
    allLifts {
        id
        name
        status
    }
}
```

このクエリーは スキーマの以下のエンドポイントにリクエストを投げる
```graphql
type Query {
  """A list of all `Lift` objects"""
  allLifts(status: LiftStatus): [Lift!]!

```

レスポンスは Lift の id, name, status のみ受け取るように指定 

スキーマとクエリーから Dart コードを作成

```
pub run build_runner build
```

lib/graphql に Dart コードが作成される
- api.dart
- api.graphql.dart
- api.graphql.g.dart

#### テスト

test/api_test.dart
```dart
import 'package:graphql/client.dart';
import 'package:graphql_project/graphql/api.graphql.dart';
import 'package:test/test.dart';

void main() {
  group('GraphQLClient Tests', () {
    HttpLink _httpLink;
    GraphQLClient _client;

    setUp(() {
      _httpLink = HttpLink('http://snowtooth.moonhighway.com');
      _client = GraphQLClient(
        cache: GraphQLCache(),
        link: _httpLink,
      );
    });

    test('AllLiftsQuery Test', () async {
      // artemis で生成されたクラスで Query クエリーを作成
      final allLiftsQuery = AllLiftsQuery();

      // graphql でクエリー実行
      final result = await _client.query(QueryOptions(
        document: allLiftsQuery.document,
      ));

      if (result.hasException) {
        print(result.exception.toString());
        return;
      }

      // artemis で生成されたクラスで結果をクラスに変換
      final responce = AllLifts$Query.fromJson(result.data);

      print('length:${responce.allLifts.length}');

      expect(responce.allLifts.length, greaterThanOrEqualTo(1));

      responce.allLifts.forEach((element) {
        print('${element.toJson()}');
      });
    });
}
```

Run Test
```sh
pub run test test/api_test.dart 
```

#### Mutation (データ更新) クエリーファイルの作成

graphql/mutation_setStatus.graphql
```graphql
mutation setStatus($id: ID!, $status:LiftStatus!)  {
    setLiftStatus(id: $id status: $status) {
        id
        name
        status
    }
}
```

Dart コードを更新
```
pub run build_runner build
```

#### テスト
SetStatusMutation の Test を追加

test/api_test.dart
```dart
    test('SetStatusMutation Test', () async {
      // artemis で生成されたクラスで Mutation クエリーを作成
      // Argumentsでタイプセーフ
      final setStatusMutation = SetStatusMutation(
        variables: SetStatusArguments(
          id: 'astra-express',
          status: LiftStatus.hold,
        ),
      );

      // graphql でクエリー実行
      final result = await _client.mutate(MutationOptions(
        document: setStatusMutation.document,
        variables: setStatusMutation.variables.toJson(),
      ));

      expect(result.hasException, equals(false));
      if (result.hasException) {
        print(result.exception.toString());
        return;
      }
      // print('${result.data}');

      // artemis で生成されたクラスで結果をクラスに変換
      final responce = SetStatus$Mutation.fromJson(result.data);
      print('${responce.setLiftStatus.toJson()}');

      expect(responce.setLiftStatus.status, equals(LiftStatus.hold));
    });
```

Run Test
```sh
pub run test test/api_test.dart 
```

## References
### Official
- [GraphQL | A query language for your API](https://graphql.org/)
- [Apollo GraphQL | Apollo Data Graph Platform— unify APIs, microservices, and databases into a data graph that you can query with GraphQL](https://www.apollographql.com/)
### Blog
- [「GraphQL」徹底入門 ─ RESTとの比較、API・フロント双方の実装から学ぶ - エンジニアHub｜若手Webエンジニアのキャリアを考える！](https://employment.en-japan.com/engineerhub/entry/2018/12/26/103000)
- [FlutterでGraphQLを実用的に使う | AABrain](https://aakira.app/blog/2020/06/flutter-graphql/)
- [Ultimate toolchain to work with GraphQL in FlutterIntro | by Vasil Vasilich](https://medium.com/@v.ditsyak/ultimate-toolchain-to-work-with-graphql-in-flutter-13aef79c6484)
- [GraphQLのクエリを基礎から整理してみた](https://qiita.com/shunp/items/d85fc47b33e1b3a88167)
- [GraphQLでMutation](https://qiita.com/NagaokaKenichi/items/e0f42c6b2aa75069b364)
### Playground
- [Playground - https://snowtooth.moonhighway.com/](http://snowtooth.moonhighway.com/)
- [APIs-guru/graphql-faker: 🎲 Mock or extend your GraphQL API with faked data. No coding required.](https://github.com/APIs-guru/graphql-faker)
- [GitHub GraphQL API v4](https://developer.github.com/v4/)
### Package
- [graphql_flutter | Flutter Package](https://pub.dev/packages/graphql_flutter)
- [graphql | Dart Package](https://pub.dev/packages/graphql)
- [artemis | Dart Package](https://pub.dev/packages/artemis)
### Tools
- [prisma-labs/get-graphql-schema: Fetch and print the GraphQL schema from a GraphQL HTTP endpoint. (Can be used for Relay Modern.)](https://github.com/prisma-labs/get-graphql-schema)
### Miscs
- [chentsulin/awesome-graphql: Awesome list of GraphQL & Relay](https://github.com/chentsulin/awesome-graphql)




