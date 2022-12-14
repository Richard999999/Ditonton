import 'package:core/core.dart';
import 'package:tvseries/data/models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchList(TvSeriesTable tv);
  Future<String> removeWatchList(TvSeriesTable tv);
  Future<TvSeriesTable?> getTvById(int id);
  Future<List<TvSeriesTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper tvDatabaseHelper;

  TvLocalDataSourceImpl({required this.tvDatabaseHelper});

  @override
  Future<String> insertWatchList(TvSeriesTable tv) async {
    try {
      await tvDatabaseHelper.insertWatchListTV(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchList(TvSeriesTable tv) async {
    try {
      await tvDatabaseHelper.removeWatchlistTV(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvById(int id) async {
    final result = await tvDatabaseHelper.getTVById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTv() async {
    final result = await tvDatabaseHelper.getWatchlistTVs();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }
}
