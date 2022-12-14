import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  const tId = 1;
  group('GetDetail Movie', () {
    blocTest<DetailMovieBloc, MovieState>(
      'should get detail movie from the usecase',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const OnDetailMovie(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), const MovieDetailHasData(testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  blocTest<DetailMovieBloc, MovieState>(
    'Should emit failure when get detail movie unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(const OnDetailMovie(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}
