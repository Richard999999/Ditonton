import 'package:dartz/dartz.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/entities/tv_season_detail.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';
import 'package:core/core.dart';

class GetSeasonDetailTv {
  final TvRepository repository;

  GetSeasonDetailTv(this.repository);

  Future<Either<Failure, TVSeasonDetail>> execute(id, seasonNumber) {
    return repository.getSeasonDetailTV(id, seasonNumber);
  }
}
