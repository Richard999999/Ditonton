import 'package:about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/search_tv_page.dart';
import 'package:tvseries/tvseries.dart';
import '../../../../core/test/helper/router_setting.dart';
import '../../helpers/bloc_helper_tv.dart';
import '../../../../search/test/presentation/pages/search_tv_page_test.dart';

void main() {
  late MockGetNowPlayTvBloc mockGetNowPlayTvBloc;
  late MockGetPopularTvBloc mockGetPopularTvBloc;
  late MockGetTopRatedTVsBloc mockGetTopRatedTVsBloc;
  late MockGetWatchlistTVsBloc mockGetWatchlistTVsBloc;
  late MockSearchTVBloc mockSearchTVBloc;

  setUpAll(() {
    mockGetNowPlayTvBloc = MockGetNowPlayTvBloc();

    mockGetPopularTvBloc = MockGetPopularTvBloc();
    mockGetTopRatedTVsBloc = MockGetTopRatedTVsBloc();
    mockGetWatchlistTVsBloc = MockGetWatchlistTVsBloc();
    mockSearchTVBloc = MockSearchTVBloc();
    registerFallbackValue(TVEventFake());
    registerFallbackValue(TVStateFake());
    registerFallbackValue(SearchEventFake());
    registerFallbackValue(SearchStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetNowplaylist>(create: (_) => mockGetNowPlayTvBloc),
        BlocProvider<PopularTvSeriesBloc>(create: (_) => mockGetPopularTvBloc),
        BlocProvider<TopRatedTvSeriesBloc>(
            create: (_) => mockGetTopRatedTVsBloc),
        BlocProvider<WatchlistBloc>(create: (_) => mockGetWatchlistTVsBloc),
        BlocProvider<SearchTVBloc>(create: (_) => mockSearchTVBloc),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routerSetting(),
      ),
    );
  }

  testWidgets('tv search testing', (WidgetTester tester) async {
    when(() => mockGetNowPlayTvBloc.state).thenReturn(TVEmpty());

    when(() => mockGetPopularTvBloc.state).thenReturn(TVEmpty());
    when(() => mockGetTopRatedTVsBloc.state).thenReturn(TVEmpty());
    when(() => mockSearchTVBloc.state).thenReturn(SearchEmpty());

    await tester.pumpWidget(_makeTestableWidget(const HomeTvPage()));

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(SearchTVPage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(HomeTvPage), findsOneWidget);
  });
}
