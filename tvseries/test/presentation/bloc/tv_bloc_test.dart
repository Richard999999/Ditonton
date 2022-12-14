import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';
import 'tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetNoowPlay,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
  GetTvDetailSeries,
  GetTvSeriesRecomen,
  GetWatchListTvSeriesbyid,
  GetWatchlistTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  GetSeasonDetailTv,
])
void main() {
  late GetNowplaylist getNowplaylist;
  late PopularTvSeriesBloc getPopularTvSeriesBloc;
  late TopRatedTvSeriesBloc getTopRatedTvSeriesBloc;
  late TvSeriesDetailBloc getTvSeriesDetailBloc;
  late TvRecomenBloc getTvRecomenBloc;
  late WatchlistBloc getWatchlistBloc;
  late GetSeasonDetailTvBloc getSeasonDetailTvBloc;

  late MockGetNoowPlay mockGetNoowPlay;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late MockGetTvDetailSeries mockGetTvDetailSeries;
  late MockGetTvSeriesRecomen mockGetTvSeriesRecomen;
  late MockGetWatchListTvSeriesbyid mockGetWatchListTvSeriesbyid;
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockGetSeasonDetailTv mockGetSeasonDetailTv;

  setUp(() {
    mockGetNoowPlay = MockGetNoowPlay();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    mockGetTvDetailSeries = MockGetTvDetailSeries();
    mockGetTvSeriesRecomen = MockGetTvSeriesRecomen();
    mockGetWatchListTvSeriesbyid = MockGetWatchListTvSeriesbyid();
    mockGetWatchlistTvSeriesStatus = MockGetWatchlistTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockGetSeasonDetailTv = MockGetSeasonDetailTv();

    getNowplaylist = GetNowplaylist(mockGetNoowPlay);
    getPopularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
    getTopRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
    getTvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvDetailSeries);
    getTvRecomenBloc = TvRecomenBloc(mockGetTvSeriesRecomen);
    getSeasonDetailTvBloc = GetSeasonDetailTvBloc(mockGetSeasonDetailTv);
    getWatchlistBloc = WatchlistBloc(
      mockGetWatchlistTvSeriesStatus,
      mockGetWatchListTvSeriesbyid,
      mockSaveWatchlistTvSeries,
      mockRemoveWatchlistTvSeries,
    );
  });

  const tId = 1;
  const tSeasonNumber = 1;
  const tSaveMessage = WatchlistBloc.watchlistAddSuccessMessage;
  const tRemoveMessage = WatchlistBloc.watchlistRemoveSuccessMessage;

  group('airing today tvs', () {
    test('initial state should be loading', () {
      expect(getNowplaylist.state, TVLoading());
    });

    blocTest<GetNowplaylist, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNoowPlay.execute())
            .thenAnswer((_) async => Right(testTvList));
        return getNowplaylist;
      },
      act: (bloc) => bloc.add(OnAiringTodayTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetNoowPlay.execute());
      },
    );

    blocTest<GetNowplaylist, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetNoowPlay.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getNowplaylist;
      },
      act: (bloc) => bloc.add(OnAiringTodayTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNoowPlay.execute());
      },
    );
  });

  group('popular tvs', () {
    test('initial state should be loading', () {
      expect(getPopularTvSeriesBloc.state, TVLoading());
    });

    blocTest<PopularTvSeriesBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(testTvList));
        return getPopularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnPopularTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
    blocTest<PopularTvSeriesBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getPopularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnPopularTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });

  group('top rated tvs', () {
    test('initial state should be loading', () {
      expect(getTopRatedTvSeriesBloc.state, TVLoading());
    });

    blocTest<TopRatedTvSeriesBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(testTvList));
        return getTopRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
    blocTest<TopRatedTvSeriesBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getTopRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTV()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });

  group('tv detail', () {
    test('initial state should be loading', () {
      expect(getTvSeriesDetailBloc.state, TVLoading());
    });

    blocTest<TvSeriesDetailBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvDetailSeries.execute(tId))
            .thenAnswer((_) async => const Right(testTVDetail));
        return getTvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const OnTvDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVDetailHasData(testTVDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetailSeries.execute(tId));
      },
    );
    blocTest<TvSeriesDetailBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetTvDetailSeries.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getTvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(const OnTvDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvDetailSeries.execute(tId));
      },
    );
  });

  group('tv recommendations', () {
    test('initial state should be loading', () {
      expect(getTvRecomenBloc.state, TVLoading());
    });

    blocTest<TvRecomenBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesRecomen.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return getTvRecomenBloc;
      },
      act: (bloc) => bloc.add(const OnTVRecomen(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        TVHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesRecomen.execute(tId));
      },
    );
    blocTest<TvRecomenBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetTvSeriesRecomen.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getTvRecomenBloc;
      },
      act: (bloc) => bloc.add(const OnTVRecomen(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesRecomen.execute(tId));
      },
    );
  });

  group('watchlist tv', () {
    group('save watchlist tv', () {
      blocTest<WatchlistBloc, TVState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlistTvSeries.execute(testTVDetail))
              .thenAnswer((_) async => const Right(tSaveMessage));
          return getWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnSaveWatchlistTv(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVWatchlistMessage(tSaveMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTvSeries.execute(testTVDetail));
        },
      );
      blocTest<WatchlistBloc, TVState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockSaveWatchlistTvSeries.execute(testTVDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return getWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnSaveWatchlistTv(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTvSeries.execute(testTVDetail));
        },
      );
    });
    group('remove watchlist tv', () {
      blocTest<WatchlistBloc, TVState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlistTvSeries.execute(testTVDetail))
              .thenAnswer((_) async => const Right(tRemoveMessage));
          return getWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveWatchlistTv(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVWatchlistMessage(tRemoveMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTvSeries.execute(testTVDetail));
        },
      );
      blocTest<WatchlistBloc, TVState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockRemoveWatchlistTvSeries.execute(testTVDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return getWatchlistBloc;
        },
        act: (bloc) => bloc.add(const OnRemoveWatchlistTv(testTVDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TVLoading(),
          const TVError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTvSeries.execute(testTVDetail));
        },
      );
    });
  });

  group('season tv detail', () {
    test('initial state should be loading', () {
      expect(getSeasonDetailTvBloc.state, TVLoading());
    });

    blocTest<GetSeasonDetailTvBloc, TVState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetSeasonDetailTv.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => const Right(testTVSeasonDetail));
        return getSeasonDetailTvBloc;
      },
      act: (bloc) => bloc.add(const OnSeasonTvDetail(tId, tSeasonNumber)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVSeasonDetailHasData(testTVSeasonDetail),
      ],
      verify: (bloc) {
        verify(mockGetSeasonDetailTv.execute(tId, tSeasonNumber));
      },
    );

    blocTest<GetSeasonDetailTvBloc, TVState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockGetSeasonDetailTv.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return getSeasonDetailTvBloc;
      },
      act: (bloc) => bloc.add(const OnSeasonTvDetail(tId, tSeasonNumber)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TVLoading(),
        const TVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetSeasonDetailTv.execute(tId, tSeasonNumber));
      },
    );
  });
}
