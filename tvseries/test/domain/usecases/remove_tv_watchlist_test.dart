import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = RemoveWatchlistTvSeries(mockTVRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTVRepository.tvRemoveWatchlist(testTVDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.tvRemoveWatchlist(testTVDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
