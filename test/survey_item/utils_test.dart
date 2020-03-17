import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Selection method tests:', () {
    setUp(() {});
    test('Check uniform random selection among a list', () {
      List<Map<String, String>> items = [
        {'key': 'q1'},
        {'key': 'q2'},
        {'key': 'q3'},
      ];
      dynamic actual =
          SelectionMethods.pickAnItem(items: items, method: 'uniform');
      expect(actual, isNotNull);
      expect(items.contains(actual), isTrue);
    });

    test('Check highest priority selection a list of maps:(num 4)\n', () {
      List<Map<String, Object>> items = [
        {'key': 'q1', 'priority': 1},
        {'key': 'q2', 'priority': 4},
        {'key': 'q3', 'priority': 2},
      ];
      dynamic actual =
          SelectionMethods.pickAnItem(items: items, method: 'highestPriority');
      Map<String, Object> expected = {'key': 'q2', 'priority': 4};
      expect(actual, expected);
      print(items);
    });

    test('Check wrong method selection of `nonuniform` defaults to uniform',
        () {
      List<Map<String, String>> items = [
        {'key': 'q1'},
        {'key': 'q2'},
        {'key': 'q3'},
      ];
      dynamic actual = SelectionMethods.pickAnItem(items: items);
      expect(actual, isNotNull);
      expect(items.contains(actual), isTrue);
    });
  });
}
