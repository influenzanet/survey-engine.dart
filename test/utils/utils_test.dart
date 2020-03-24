import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:test/test.dart';

void main() {
  group(
      'Test resolution of null parameters to return null of the cheking variable is null or resolve otherwise :\n',
      () {
    setUp(() {});
    test('Check if `null` is returned on nullCheck=`null`', () {
      expect(Utils.resolveNull(null, 'replacedValue'), isNull);
    });
  });

  test('Check if `5` is returned on nullCheck=`value` and nullReplace = `5`',
      () {
    expect(Utils.resolveNull('value', '5'), '5');
  });
}
