import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:tvseries/domain/entities/tv_season_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, TVSeasonDetail>> getSeasonDetailTV(
      int id, int seasonNumber);
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendation(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> tvSaveWatchList(TvDetail tv);
  Future<Either<Failure, String>> tvRemoveWatchlist(TvDetail tv);
  Future<bool> isTvAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
  Future<Either<Failure, List<Tv>>> getNoowPlay();
}
