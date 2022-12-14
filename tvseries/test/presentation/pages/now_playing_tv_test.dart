import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieseries/movieseries.dart';

import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';

Route<dynamic> Function(RouteSettings settings) routerSetting() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case HOME_MOVIE_ROUTE:
        return MaterialPageRoute(builder: (_) => const HomeMoviePage());
      case NOW_PLAYING_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => const NowPlay());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
  };
}

class MockGetNowplaylistFake extends MockBloc<TVEvent, TVState>
    implements GetNowplaylist {
  execute() {}
}

class GetNowPlayEventFake extends Fake implements TVEvent {}

class GetNowPlayStateFake extends Fake implements TVState {}

void main() {
  late MockGetNowplaylistFake mockGetNowplaylist;

  setUpAll(() {
    mockGetNowplaylist = MockGetNowplaylistFake();
    registerFallbackValue(GetNowPlayEventFake());
    registerFallbackValue(GetNowPlayStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetNowplaylist>(create: (_) => mockGetNowplaylist),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockGetNowplaylist.state).thenReturn(TVLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const NowPlay()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockGetNowplaylist.state).thenReturn(TVHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const NowPlay()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display TVCard when data is loaded',
      (WidgetTester tester) async {
    when(() => mockGetNowplaylist.state).thenReturn(TVHasData(testTvList));

    final tvCardFinder = find.byType(TvCard);

    await tester.pumpWidget(_makeTestableWidget(const NowPlay()));

    expect(tvCardFinder, findsOneWidget);

    await tester.tap(find.byType(TvCard));
  });

  testWidgets('Page should display text with message when empty',
      (WidgetTester tester) async {
    when(() => mockGetNowplaylist.state).thenReturn(TVEmpty());

    final textFinder = find.byKey(const Key('empty'));

    await tester.pumpWidget(_makeTestableWidget(const NowPlay()));

    expect(textFinder, findsOneWidget);
  });
}
