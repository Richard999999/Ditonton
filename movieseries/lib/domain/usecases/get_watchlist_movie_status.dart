import 'package:dartz/dartz.dart';
import 'package:movieseries/domain/entities/movie.dart';
import 'package:movieseries/domain/repositories/movie_repository.dart';
import 'package:core/core.dart';

class GetWatchlistMovieStatus {
  final MovieRepository _repository;

  GetWatchlistMovieStatus(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
