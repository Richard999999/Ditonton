import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';

void main() {
  test('should be json form TVTable', () async {
    // assert
    final result = testTvTable.toJson();
    // act
    expect(result, testTVTableJson);
  });
}
