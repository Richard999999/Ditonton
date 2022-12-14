import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';

class MockPopularTvSeriesBloc extends MockBloc<TVEvent, TVState>
    implements PopularTvSeriesBloc {
  execute() {}
}

class PopularTvSeriesBlocEventFake extends Fake implements TVEvent {}

class PopularTvSeriesBlocStateFake extends Fake implements TVState {}

void main() {
  late MockPopularTvSeriesBloc mockPopularTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(PopularTvSeriesBlocEventFake());
    registerFallbackValue(PopularTvSeriesBlocStateFake());
  });

  setUp(() {
    mockPopularTvSeriesBloc = MockPopularTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>(
      create: (context) => mockPopularTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Popular TV Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularTvSeriesBloc.state).thenReturn(TVLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockPopularTvSeriesBloc.state)
          .thenReturn(TVHasData(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

      expect(listViewFinder, findsOneWidget);
    });
  });
}
