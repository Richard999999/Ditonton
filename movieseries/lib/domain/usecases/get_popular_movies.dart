import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movieseries/domain/entities/movie.dart';
import 'package:movieseries/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
