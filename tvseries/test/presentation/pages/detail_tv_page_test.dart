import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';

//=========================== detail TV =====================================
class MockDetailTVBloc extends MockBloc<TVEvent, TVState>
    implements TvSeriesDetailBloc {}

class DetailTVEventFake extends Fake implements TVEvent {}

class DetailTVStateFake extends Fake implements TVState {}

//============================ watchlist =======================================
class MockWatchlistBloc extends MockBloc<TVEvent, TVState>
    implements WatchlistBloc {}

class WatchlistEventFake extends Fake implements TVEvent {}

class WatchlistStateFake extends Fake implements TVState {}

//======================== recommendations TV ===============================
class MockRecommendationTVBloc extends MockBloc<TVEvent, TVState>
    implements TvRecomenBloc {}

class RecommendationTVEventFake extends Fake implements TVEvent {}

class RecommendationTVStateFake extends Fake implements TVState {}

void main() {
  late MockDetailTVBloc mockDetailTVBloc;
  late MockWatchlistBloc mockWatchlistBloc;
  late MockRecommendationTVBloc recommendationTVBloc;

  setUpAll(() {
    registerFallbackValue(DetailTVEventFake());
    registerFallbackValue(DetailTVStateFake());
    registerFallbackValue(WatchlistEventFake());
    registerFallbackValue(WatchlistStateFake());
    registerFallbackValue(RecommendationTVEventFake());
    registerFallbackValue(RecommendationTVStateFake());
  });

  setUp(() {
    mockDetailTVBloc = MockDetailTVBloc();
    mockWatchlistBloc = MockWatchlistBloc();
    recommendationTVBloc = MockRecommendationTVBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (context) => mockDetailTVBloc,
        ),
        BlocProvider<WatchlistBloc>(
          create: (context) => mockWatchlistBloc,
        ),
        BlocProvider<TvRecomenBloc>(
          create: (context) => recommendationTVBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Detail TV Page', () {
    testWidgets(
        'Watchlist button should display add icon when TV not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailTVBloc.state)
          .thenReturn(const TVDetailHasData(testTVDetail));
      when(() => recommendationTVBloc.state).thenReturn(TVHasData(testTvList));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const TVWatchlistStatus(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when TV is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockDetailTVBloc.state)
          .thenReturn(const TVDetailHasData(testTVDetail));
      when(() => recommendationTVBloc.state).thenReturn(TVHasData(testTvList));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const TVWatchlistStatus(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });
  });
}
