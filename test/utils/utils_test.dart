import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:test/test.dart';

void main() {
  group(
      'Test resolution of null parameters to return null of the cheking variable is null or resolve otherwise :\n',
      () {
    setUp(() {});
    test('Check if `null` is returned on nullCheck=`null`', () {
      expect(Utils.resolveNullList(null), isNull);
    });
  });

  test(
      'Check if a list of dynamic items is sent it returns the List of map of the dynamic list',
      () {
    expect(Utils.resolveNullList([1, 2, 3]), [1, 2, 3]);
  });
}
