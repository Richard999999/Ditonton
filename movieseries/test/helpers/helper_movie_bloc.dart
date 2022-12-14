import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';

class MovieStateFake extends Fake implements MovieState {}

class MovieEventFake extends Fake implements MovieEvent {}

class MockGetNowPlayingMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements PlayingNowMovieBloc {}

class MockGetPopularMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMovieBloc {}

class MockGetTopRatedMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMovieBloc {}

class MockGetMovieDetailBloc extends MockBloc<MovieEvent, MovieState>
    implements DetailMovieBloc {}

class MockGetMovieRecommendationsBloc extends MockBloc<MovieEvent, MovieState>
    implements RecommendationMovieBloc {}

class MockGetWatchlistMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements WatchlistMovieBloc {}
