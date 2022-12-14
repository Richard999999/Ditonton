import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/usecases/get_tv_recomen.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvSeriesRecomen usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetTvSeriesRecomen(mockTVRepository);
  });

  const tId = 1;
  final tv = <Tv>[];

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(mockTVRepository.getTvRecommendation(tId))
        .thenAnswer((_) async => Right(tv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tv));
  });
}
