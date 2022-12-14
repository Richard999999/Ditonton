import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/presentation/widgets/watchlist_tv_page.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';

class MockWatchlistTVBloc extends MockBloc<TVEvent, TVState>
    implements WatchlistBloc {}

class WatchlistTVEventFake extends Fake implements TVEvent {}

class WatchlistTVStateFake extends Fake implements TVState {}

void main() {
  late MockWatchlistTVBloc mockWatchlistTVBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistTVEventFake());
    registerFallbackValue(WatchlistTVStateFake());
  });

  setUp(() {
    mockWatchlistTVBloc = MockWatchlistTVBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistBloc>(
      create: (context) => mockWatchlistTVBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Watchlist TV Page', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(
        () => mockWatchlistTVBloc.state,
      ).thenReturn(TVLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(const WatchlistTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });
  });

  testWidgets('should be show TVCard List when Watchlist success loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistTVBloc.state).thenReturn(TVHasData(testTvList));

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistTvPage())));

    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistTVBloc.state).thenReturn(TVLoading());

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistTvPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error',
      (WidgetTester tester) async {
    when(() => mockWatchlistTVBloc.state).thenReturn(const TVError('Failed'));

    await tester.pumpWidget(
        _makeTestableWidget(const Material(child: WatchlistTvPage())));

    expect(find.text('Failed'), findsOneWidget);
  });
}
