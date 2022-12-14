import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';

class GetPopularTvSeries {
  final TvRepository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
