import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';

void main() {
  test('should be json form TVDetailResponse', () async {
    // assert
    final result = testTVDetailResponse.toJson();
    // act
    expect(result, testTVDetailResponseJson);
  });
}
