import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import 'package:movieseries/presentation/widgets/watchlist_movie_page.dart';
import '../../dummy_data/dummy_objects_movie.dart';

class MockWatchlistMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements WatchlistMovieBloc {}

class WatchlistMovieEventFake extends Fake implements MovieEvent {}

class WatchlistMovieStateFake extends Fake implements MovieState {}

void main() {
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistMovieEventFake());
    registerFallbackValue(WatchlistMovieStateFake());
  });

  setUp(() {
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>(
      create: (context) => mockWatchlistMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Watchlist Movie Page', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(
        () => mockWatchlistMovieBloc.state,
      ).thenReturn(MovieLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const MovieError('Failed'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
