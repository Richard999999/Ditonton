import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import 'recomen_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMovieBloc recommendationMovie;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovie = RecommendationMovieBloc(mockGetMovieRecommendations);
  });

  const tId = 1;
  group('Get Recommendations Movie', () {
    blocTest<RecommendationMovieBloc, MovieState>(
      'should get data recomendations movie from the usecase',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return recommendationMovie;
      },
      act: (bloc) => bloc.add(const OnMovieRecommendations(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), MovieHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  blocTest<RecommendationMovieBloc, MovieState>(
    'Should emit error when get recommendations unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationMovie;
    },
    act: (bloc) => bloc.add(const OnMovieRecommendations(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}
