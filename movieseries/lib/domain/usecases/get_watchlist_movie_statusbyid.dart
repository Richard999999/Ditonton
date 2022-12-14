import 'package:movieseries/movieseries.dart';

class GetWatchListMovieStatusByid {
  final MovieRepository repository;

  GetWatchListMovieStatusByid(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
