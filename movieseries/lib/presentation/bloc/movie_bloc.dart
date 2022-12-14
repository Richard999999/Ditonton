import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieseries/movieseries.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class PlayingNowMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovie;
  PlayingNowMovieBloc(this._getNowPlayingMovie) : super(MovieLoading()) {
    on<OnNowPlayingMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getNowPlayingMovie.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(MovieLoading()) {
    on<OnPopularMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(MovieLoading()) {
    on<OnTopRatedMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

class DetailMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(MovieLoading()) {
    on<OnDetailMovie>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieDetailHasData(data)),
      );
    });
  }
}

class RecommendationMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMovieBloc(this._getMovieRecommendations)
      : super(MovieLoading()) {
    on<OnMovieRecommendations>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}

class WatchlistMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchListMovieStatusByid _getWatchListStatusbyid;
  final GetWatchlistMovieStatus _getWatchlistMoviesStatus;
  final SaveWachListMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistMovieBloc(
    this._getWatchListStatusbyid,
    this._getWatchlistMoviesStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(MovieLoading()) {
    on<OnWatchlistMovies>((event, emit) async {
      emit(MovieLoading());

      final result = await _getWatchlistMoviesStatus.execute();
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
    on<OnWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());

      final result = await _getWatchListStatusbyid.execute(id);
      emit(MovieWatchlistStatus(result));
    });
    on<OnSaveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      emit(MovieLoading());

      final result = await _saveWatchlist.execute(movie);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieWatchlistMessage(data)),
      );
    });
    on<OnRemoveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      emit(MovieLoading());

      final result = await _removeWatchlist.execute(movie);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieWatchlistMessage(data)),
      );
    });
  }
}
