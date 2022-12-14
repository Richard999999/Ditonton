import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvRepository mockTVRpository;

  setUp(() {
    mockTVRpository = MockTvRepository();
    usecase = GetPopularTvSeries(mockTVRpository);
  });

  final tv = <Tv>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVRpository.getPopularTv()).thenAnswer((_) async => Right(tv));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tv));
      });
    });
  });
}
