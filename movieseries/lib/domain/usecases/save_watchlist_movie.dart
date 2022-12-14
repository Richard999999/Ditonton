import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movieseries/movieseries.dart';

class SaveWachListMovie {
  final MovieRepository repository;

  SaveWachListMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
