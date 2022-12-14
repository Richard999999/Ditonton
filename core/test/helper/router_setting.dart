import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieseries/movieseries.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

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
