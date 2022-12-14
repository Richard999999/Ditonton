import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';

class GetTvSeriesRecomen {
  final TvRepository repository;

  GetTvSeriesRecomen(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendation(id);
  }
}
