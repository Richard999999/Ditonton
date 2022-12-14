import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';

import '../../dummy_data/dummy_objects_movie.dart';

class MockPopularMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMovieBloc {}

class PopularMovieEventFake extends Fake implements MovieEvent {}

class PopularMovieStateFake extends Fake implements MovieState {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUpAll(() {
    registerFallbackValue(PopularMovieEventFake());
    registerFallbackValue(PopularMovieStateFake());
  });

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (context) => mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Popular Movie Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularMovieBloc.state).thenReturn(MovieLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockPopularMovieBloc.state)
          .thenReturn(MovieHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });
  });
}
