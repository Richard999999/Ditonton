import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';

class RemoveWatchlistTvSeries {
  final TvRepository repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.tvRemoveWatchlist(tv);
  }
}
