import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';
import 'package:tvseries/domain/entities/tv.dart';
import '../../../../tvseries/test/helpers/test_helper_tv.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = SearchTvSeries(mockTVRepository);
  });

  final tTVs = <Tv>[];
  const tQuery = 'Spiderman';

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mockTVRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTVs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTVs));
  });
}
