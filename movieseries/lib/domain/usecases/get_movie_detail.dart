import 'package:dartz/dartz.dart';
import 'package:movieseries/domain/entities/movie_detail.dart';
import 'package:movieseries/domain/repositories/movie_repository.dart';
import 'package:core/core.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
