import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetTopRatedTvSeries(mockTVRepository);
  });

  final tv = <Tv>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockTVRepository.getTopRatedTv()).thenAnswer((_) async => Right(tv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tv));
  });
}
