import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetWatchlistTvSeriesStatus {
  final TvRepository _repository;

  GetWatchlistTvSeriesStatus(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
