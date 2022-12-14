import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';

class SaveWatchlistTvSeries {
  final TvRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.tvSaveWatchList(tv);
  }
}
