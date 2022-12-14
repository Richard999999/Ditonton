import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetTvDetailSeries {
  final TvRepository repository;

  GetTvDetailSeries(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
