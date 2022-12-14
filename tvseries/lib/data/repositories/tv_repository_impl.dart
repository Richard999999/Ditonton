import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/domain/entities/tv_season_detail.dart';
import 'package:tvseries/tvseries.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteData remoteDataSource;
  final TvLocalDataSource tvlocalDataSource;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.tvlocalDataSource,
  });

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTv() async {
    try {
      final result = await remoteDataSource.getNowPlayingTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SslHandler(e.message));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SslHandler(e.message));
    }
  }

  @override
  Future<Either<Failure, TVSeasonDetail>> getSeasonDetailTV(
      int id, int seasonNumber) async {
    try {
      final result = await remoteDataSource.getSeasonDetailTV(id, seasonNumber);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendation(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendation(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getNoowPlay() async {
    try {
      final result = await remoteDataSource.getNoowPlay();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SslHandler(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SslHandler(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SslHandler(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    try {
      final result = await tvlocalDataSource.getWatchlistTv();
      return Right(result.map((data) => data.toEntity()).toList());
    } on TlsException catch (e) {
      return Left(SslHandler(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(SslHandler(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> tvSaveWatchList(TvDetail tv) async {
    try {
      final result =
          await tvlocalDataSource.insertWatchList(TvSeriesTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> tvRemoveWatchlist(TvDetail tv) async {
    try {
      final result =
          await tvlocalDataSource.removeWatchList(TvSeriesTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isTvAddedToWatchlist(int id) async {
    final result = await tvlocalDataSource.getTvById(id);
    return result != null;
  }
}
