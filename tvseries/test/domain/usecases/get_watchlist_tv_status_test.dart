import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_watchlist_tv_statusbyid.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetWatchListTvSeriesbyid usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetWatchListTvSeriesbyid(mockTVRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTVRepository.isTvAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
