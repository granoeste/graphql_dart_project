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
      final result = await _client.query(QueryOptions(
        document: AllLiftsQuery().document,
      ));

      if (result.hasException) {
        print(result.exception.toString());
        return;
      }

      final allLifts = AllLifts$Query.fromJson(result.data).allLifts;
      print('length:${allLifts.length}');
      expect(allLifts.length, greaterThanOrEqualTo(1));
      allLifts.forEach((element) {
        print('${element.toJson()}');
      });
    });

    test('SetStatusMutation Test', () async {
      final result = await _client.mutate(MutationOptions(
        document: SetStatusMutation().document,
        variables: <String, dynamic>{
          'id': 'astra-express',
          'status': 'HOLD',
        },
      ));

      if (result.hasException) {
        print(result.exception.toString());
        return;
      }
      print('${result.data}');

      final lift = SetStatus$Mutation$Lift.fromJson(result.data);
      print('${lift.props}');
    });
  });
}
