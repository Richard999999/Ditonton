import 'package:about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import 'package:movieseries/presentation/pages/home_movie_page.dart';
import 'package:search/search.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import '../../../../core/test/helper/router_setting.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import '../../../../search/test/presentation/pages/search_movie_page_test.dart';
import '../../helpers/helper_movie_bloc.dart';
import '../../../../tvseries/test/helpers/bloc_helper_tv.dart';

void main() {
  late MockGetNowPlayingMovieBloc mockGetNowPlayingMovieBloc;
  late MockGetPopularMoviesBloc mockGetPopularMoviesBloc;
  late MockGetTopRatedMoviesBloc mockGetTopRatedMoviesBloc;
  late MockGetWatchlistMoviesBloc mockGetWatchlistMoviesBloc;

  late MockSearchBloc mockSearchBloc;

  late MockGetNowPlayTvBloc mockGetAiringTodayTVBloc;
  late MockGetPopularTvBloc mockGetPopularTVsBloc;
  late MockGetTopRatedTVsBloc mockGetTopRatedTVsBloc;

  setUpAll(() {
    mockGetNowPlayingMovieBloc = MockGetNowPlayingMovieBloc();
    mockGetPopularMoviesBloc = MockGetPopularMoviesBloc();
    mockGetTopRatedMoviesBloc = MockGetTopRatedMoviesBloc();
    mockGetWatchlistMoviesBloc = MockGetWatchlistMoviesBloc();

    mockSearchBloc = MockSearchBloc();

    mockGetAiringTodayTVBloc = MockGetNowPlayTvBloc();
    mockGetPopularTVsBloc = MockGetPopularTvBloc();
    mockGetTopRatedTVsBloc = MockGetTopRatedTVsBloc();

    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());

    registerFallbackValue(SearchEventFake());
    registerFallbackValue(SearchStateFake());

    registerFallbackValue(TVEventFake());
    registerFallbackValue(TVStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayingNowMovieBloc>(
            create: (_) => mockGetNowPlayingMovieBloc),
        BlocProvider<PopularMovieBloc>(create: (_) => mockGetPopularMoviesBloc),
        BlocProvider<TopRatedMovieBloc>(
            create: (_) => mockGetTopRatedMoviesBloc),
        BlocProvider<WatchlistMovieBloc>(
            create: (_) => mockGetWatchlistMoviesBloc),
        BlocProvider<SearchBloc>(create: (_) => mockSearchBloc),
        BlocProvider<GetNowplaylist>(create: (_) => mockGetAiringTodayTVBloc),
        BlocProvider<PopularTvSeriesBloc>(create: (_) => mockGetPopularTVsBloc),
        BlocProvider<TopRatedTvSeriesBloc>(
            create: (_) => mockGetTopRatedTVsBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  group('Show ', () {
    testWidgets('show MovieList when Now Playing success fetch data',
        (WidgetTester tester) async {
      when(() => mockGetNowPlayingMovieBloc.state)
          .thenReturn(MovieHasData(testMovieList));
      when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieEmpty());

      final movieList = find.byType(MovieList);
      final keyFailedPopularMovies =
          find.byKey(const Key('failed_popular_movies'));
      final keyFailedTopRatedMovies =
          find.byKey(const Key('failed_top_rated_movies'));

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(movieList, findsOneWidget);
      expect(keyFailedPopularMovies, findsOneWidget);
      expect(keyFailedTopRatedMovies, findsOneWidget);

      await tester.tap(find.byType(CachedNetworkImage));
    });

    testWidgets('show CircularLoading when loading fetch data',
        (WidgetTester tester) async {
      when(() => mockGetNowPlayingMovieBloc.state).thenReturn(MovieLoading());
      when(() => mockGetPopularMoviesBloc.state).thenReturn(MovieLoading());
      when(() => mockGetTopRatedMoviesBloc.state).thenReturn(MovieLoading());

      final typeCircularProgressIndicator =
          find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

      expect(typeCircularProgressIndicator, findsNWidgets(3));
    });
  });
}
