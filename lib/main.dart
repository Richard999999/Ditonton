import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieseries/movieseries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import 'package:movieseries/presentation/widgets/watchlist_movie_page.dart';
import 'package:search/search.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<PlayingNowMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<GetNowplaylist>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecomenBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTVBloc>(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          debugShowCheckedModeBanner: false,
          home: HomeMoviePage(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: routerSetting()),
    );
  }
}

Route<dynamic> Function(RouteSettings settings) routerSetting() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case HOME_MOVIE_ROUTE:
        return MaterialPageRoute(builder: (_) => HomeMoviePage());
      case POPULAR_MOVIES_ROUTE:
        return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
      case TOP_RATED_MOVIE_ROUTE:
        return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
      case MOVIE_DETAIL_ROUTE:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailPage(id: id),
          settings: settings,
        );
      case SEARCH_ROUTE:
        return CupertinoPageRoute(builder: (_) => SearchPage());
      case WATCHLIST_ROUTE:
        return MaterialPageRoute(builder: (_) => WatchListPage());
      case HOME_TV_ROUTE:
        return MaterialPageRoute(builder: (_) => HomeTvPage());
      case POPULAR_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => PopularTvPage());
      case TOP_RATED_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
      case NOW_PLAYING_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => NowPlay());
      case DETAIL_TV_ROUTE:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => TVDetailPage(id: id),
          settings: settings,
        );
      case SEARCH_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => SearchTVPage());
      case ABOUT_ROUTE:
        return MaterialPageRoute(builder: (_) => AboutPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
  };
}
