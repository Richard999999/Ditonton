import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import 'package:movieseries/presentation/widgets/watchlist_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:core/utils/utils.dart';
import 'package:movieseries/movieseries.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/presentation/widgets/watchlist_tv_page.dart';
import 'package:tvseries/tvseries.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
    Future.microtask(() {
      BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
          .add(OnWatchlistMovies());
      BlocProvider.of<WatchlistBloc>(context, listen: false)
          .add(OnWatchlistTVs());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
        .add(OnWatchlistMovies());
    BlocProvider.of<WatchlistBloc>(context, listen: false).add(
      OnWatchlistTVs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(
              text: 'Movies',
            ),
            Tab(
              text: 'TV Series',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          WatchlistMoviesPage(),
          WatchlistTvPage(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }
}
