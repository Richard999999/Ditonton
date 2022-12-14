import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovieStatus,
  GetWatchListMovieStatusByid,
  SaveWachListMovie,
  RemoveWatchlistMovie
])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchListMovieStatusByid mockGetWatchListMovieStatusByid;
  late MockGetWatchlistMovieStatus mockGetWatchlistMovieStatus;
  late MockSaveWachListMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetWatchListMovieStatusByid = MockGetWatchListMovieStatusByid();
    mockGetWatchlistMovieStatus = MockGetWatchlistMovieStatus();
    mockSaveWatchlistMovie = MockSaveWachListMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();

    watchlistMovieBloc = WatchlistMovieBloc(
      mockGetWatchListMovieStatusByid,
      mockGetWatchlistMovieStatus,
      mockSaveWatchlistMovie,
      mockRemoveWatchlistMovie,
    );
  });

  group('Get Watchlist Movie', () {
    blocTest<WatchlistMovieBloc, MovieState>(
      'should get data movie from the usecase',
      build: () {
        when(mockGetWatchlistMovieStatus.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [MovieLoading(), MovieHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetWatchlistMovieStatus.execute());
      },
    );
  });

  blocTest<WatchlistMovieBloc, MovieState>(
    'Should emit error when get watchlist unsuccessful',
    build: () {
      when(mockGetWatchlistMovieStatus.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(OnWatchlistMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovieStatus.execute());
    },
  );
}
