import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';
import 'package:tvseries/domain/usecases/get_noowplay_tv.dart';

import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetNoowPlay use;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    use = GetNoowPlay(mockTvRepository);
  });

  final tTVs = <Tv>[];

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mockTvRepository.getNoowPlay()).thenAnswer((_) async => Right(tTVs));
    // act
    final result = await use.execute();
    // assert
    expect(result, Right(tTVs));
  });
}
