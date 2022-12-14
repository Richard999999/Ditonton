import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';

class MockTopRatedTvSeriesBloc extends MockBloc<TVEvent, TVState>
    implements TopRatedTvSeriesBloc {}

class TopRatedTvSeriesBlocEventFake extends Fake implements TVEvent {}

class TopRatedTvSeriesBlocStateFake extends Fake implements TVState {}

void main() {
  late MockTopRatedTvSeriesBloc mockTopRatedTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTvSeriesBlocEventFake());
    registerFallbackValue(TopRatedTvSeriesBlocStateFake());
  });

  setUp(() {
    mockTopRatedTvSeriesBloc = MockTopRatedTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesBloc>(
      create: (context) => mockTopRatedTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Top Rated TV Page', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(
        () => mockTopRatedTvSeriesBloc.state,
      ).thenReturn(TVLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockTopRatedTvSeriesBloc.state)
          .thenReturn(TVHasData(testTvList));
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
    });
  });
}
