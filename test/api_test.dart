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
        cache: GraphQLCache(
            // The default store is the InMemoryStore, which does NOT persist to disk
            // store: HiveStore(),
            ),
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
  });
}
