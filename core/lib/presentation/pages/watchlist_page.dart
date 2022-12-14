import 'package:flutter/material.dart';
import 'package:movieseries/movieseries.dart';
import 'package:movieseries/presentation/widgets/watchlist_movie_page.dart';
import 'package:tvseries/presentation/widgets/watchlist_tv_page.dart';
import 'package:tvseries/tvseries.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final List<Tab> _myTab = [
    const Tab(
      text: 'Movie',
    ),
    const Tab(
      text: 'TV Series',
    ),
  ];

  final List<Widget> __myTabBarView = [
    const WatchlistMoviesPage(),
    const WatchlistTvPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return DefaultTabController(
          length: _myTab.length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Watchlist'),
              bottom: TabBar(
                tabs: _myTab,
              ),
            ),
            body: TabBarView(
              children: __myTabBarView,
            ),
          ),
        );
      },
    );
  }
}
