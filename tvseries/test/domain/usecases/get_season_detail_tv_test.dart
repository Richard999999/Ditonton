import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetSeasonDetailTv usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetSeasonDetailTv(mockTVRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  test('should get TVSeasonDetail from the repository', () async {
    // arrange
    when(mockTVRepository.getSeasonDetailTV(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(testTVSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(testTVSeasonDetail));
  });
}
