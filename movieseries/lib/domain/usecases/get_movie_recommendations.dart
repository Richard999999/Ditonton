import 'package:dartz/dartz.dart';
import 'package:movieseries/domain/entities/movie.dart';
import 'package:movieseries/domain/repositories/movie_repository.dart';
import 'package:core/core.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
