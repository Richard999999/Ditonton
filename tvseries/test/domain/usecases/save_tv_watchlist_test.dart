import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should save Tv to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.tvSaveWatchList(testTVDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTvSeriesRepository.tvSaveWatchList(testTVDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
