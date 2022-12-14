import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import '../../dummy_data/dummy_objects_movie.dart';

class MockTopRatedMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMovieBloc {}

class TopRatedMovieEventFake extends Fake implements MovieEvent {}

class TopRatedMovieStateFake extends Fake implements MovieState {}

void main() {
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMovieEventFake());
    registerFallbackValue(TopRatedMovieStateFake());
  });

  setUp(() {
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (context) => mockTopRatedMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Top Rated Movie Page', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(
        () => mockTopRatedMovieBloc.state,
      ).thenReturn(MovieLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(MovieHasData(testMovieList));
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });
  });
}
