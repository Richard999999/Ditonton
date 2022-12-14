import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import '../../dummy_data/dummy_objects_movie.dart';

class MovieStateFake extends Fake implements MovieState {}

class MovieEventFake extends Fake implements MovieEvent {}

class MockGetMovieDetailBloc extends MockBloc<MovieEvent, MovieState>
    implements DetailMovieBloc {}

class MockGetMovieRecommendationsBloc extends MockBloc<MovieEvent, MovieState>
    implements RecommendationMovieBloc {}

class MockGetWatchlistMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements WatchlistMovieBloc {}

void main() {
  late MockGetMovieDetailBloc mockGetMovieDetailBloc;
  late MockGetMovieRecommendationsBloc mockGetMovieRecommendationsBloc;
  late MockGetWatchlistMoviesBloc mockGetWatchlistMoviesBloc;

  setUpAll(() {
    mockGetMovieDetailBloc = MockGetMovieDetailBloc();
    mockGetMovieRecommendationsBloc = MockGetMovieRecommendationsBloc();
    mockGetWatchlistMoviesBloc = MockGetWatchlistMoviesBloc();
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(create: (_) => mockGetMovieDetailBloc),
        BlocProvider<RecommendationMovieBloc>(
            create: (_) => mockGetMovieRecommendationsBloc),
        BlocProvider<WatchlistMovieBloc>(
            create: (_) => mockGetWatchlistMoviesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetailOrther));
    when(() => mockGetMovieRecommendationsBloc.state)
        .thenReturn(MovieHasData(testMovieList));
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(const MovieWatchlistStatus(true));
    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(WatchlistMovieBloc.watchlistAddSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(const MovieWatchlistStatus(true));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(WatchlistMovieBloc.watchlistRemoveSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(const MovieError('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('loading progress bar', (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state).thenReturn(MovieLoading());
    when(() => mockGetMovieRecommendationsBloc.state)
        .thenReturn(MovieLoading());
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets('recomendation movie loading progress bar',
      (WidgetTester tester) async {
    when(() => mockGetMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockGetMovieRecommendationsBloc.state)
        .thenReturn(MovieLoading());
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));

    final circularProgressIndicator = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(circularProgressIndicator, findsWidgets);
  });
}
