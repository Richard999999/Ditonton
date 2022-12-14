import 'package:tvseries/domain/repositories/tv_repository.dart';

class GetWatchListTvSeriesbyid {
  final TvRepository repository;

  GetWatchListTvSeriesbyid(this.repository);

  Future<bool> execute(int id) async {
    return repository.isTvAddedToWatchlist(id);
  }
}
