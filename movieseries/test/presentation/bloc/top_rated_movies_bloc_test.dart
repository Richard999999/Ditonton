import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  group('Get Top rated Movie', () {
    blocTest<TopRatedMovieBloc, MovieState>(
      'should get Top rated movie from the usecase',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), MovieHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  blocTest<TopRatedMovieBloc, MovieState>(
    'Should emit failure when get Top rated unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
