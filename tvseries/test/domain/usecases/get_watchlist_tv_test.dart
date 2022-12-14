import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetWatchlistTvSeriesStatus usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetWatchlistTvSeriesStatus(mockTVRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTVRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
