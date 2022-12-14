// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';

class GetTopRatedTvSeries {
  final TvRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
