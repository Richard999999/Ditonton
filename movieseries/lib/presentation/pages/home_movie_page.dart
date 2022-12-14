import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:movieseries/movieseries.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          BlocProvider.of<PlayingNowMovieBloc>(context, listen: false)
              .add(OnNowPlayingMovie()),
          BlocProvider.of<TopRatedMovieBloc>(context, listen: false)
              .add(OnTopRatedMovie()),
          BlocProvider.of<PopularMovieBloc>(context, listen: false)
              .add(OnPopularMovie()),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              //FirebaseCrashlytics.instance.crash();
              Navigator.pushNamed(context, SEARCH_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Movie Page',
                  style: GoogleFonts.lato(
                      color: kMikadoYellow,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<PlayingNowMovieBloc, MovieState>(
                  builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieHasData) {
                  return MovieList(state.result);
                } else if (state is MovieError) {
                  return Center(
                      child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.amber),
                  ));
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_MOVIE_ROUTE),
              ),
              BlocBuilder<TopRatedMovieBloc, MovieState>(
                  builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieHasData) {
                  return MovieList(state.result);
                } else if (state is MovieError) {
                  return Center(
                      child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.amber),
                  ));
                } else {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Failed connect to network',
                        key: Key('failed_popular_movies'),
                      ),
                    ),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
              ),
              BlocBuilder<PopularMovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieHasData) {
                    return MovieList(state.result);
                  } else if (state is MovieError) {
                    return Center(
                        child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.amber),
                    ));
                  } else {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Failed connect to network',
                          key: Key('failed_top_rated_movies'),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MOVIE_DETAIL_ROUTE,
                    arguments: movie.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          itemCount: movies.length,
        ),
      ),
    );
  }
}
