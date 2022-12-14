import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import 'playing_now_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late PlayingNowMovieBloc playingNowMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    playingNowMovieBloc = PlayingNowMovieBloc(mockGetNowPlayingMovies);
  });

  const tId = 1;

  group('Get Now Playing Movie', () {
    blocTest<PlayingNowMovieBloc, MovieState>(
      'should get data movie from the usecase',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return playingNowMovieBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), MovieHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  blocTest<PlayingNowMovieBloc, MovieState>(
    'Should emit error when get now playing unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return playingNowMovieBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingMovie()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
