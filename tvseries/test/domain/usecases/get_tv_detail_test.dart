import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvDetailSeries usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetTvDetailSeries(mockTVRepository);
  });

  const tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockTVRepository.getTvDetail(tId))
        .thenAnswer((_) async => const Right(testTVDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testTVDetail));
  });
}
