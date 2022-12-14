import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv_season_detail.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class GetNowplaylist extends Bloc<TVEvent, TVState> {
  final GetNoowPlay _getAiringTodayTV;
  GetNowplaylist(this._getAiringTodayTV) : super(TVLoading()) {
    on<OnAiringTodayTV>((event, emit) async {
      emit(TVLoading());
      final result = await _getAiringTodayTV.execute();

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class PopularTvSeriesBloc extends Bloc<TVEvent, TVState> {
  final GetPopularTvSeries _getPopularTVs;

  PopularTvSeriesBloc(this._getPopularTVs) : super(TVLoading()) {
    on<OnPopularTV>((event, emit) async {
      emit(TVLoading());
      final result = await _getPopularTVs.execute();

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class TopRatedTvSeriesBloc extends Bloc<TVEvent, TVState> {
  final GetTopRatedTvSeries _getTopRatedTVs;

  TopRatedTvSeriesBloc(this._getTopRatedTVs) : super(TVLoading()) {
    on<OnTopRatedTV>((event, emit) async {
      emit(TVLoading());
      final result = await _getTopRatedTVs.execute();

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class TvSeriesDetailBloc extends Bloc<TVEvent, TVState> {
  final GetTvDetailSeries _getTVDetail;

  TvSeriesDetailBloc(this._getTVDetail) : super(TVLoading()) {
    on<OnTvDetail>((event, emit) async {
      final id = event.id;

      emit(TVLoading());
      final result = await _getTVDetail.execute(id);

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVDetailHasData(data)),
      );
    });
  }
}

class TvRecomenBloc extends Bloc<TVEvent, TVState> {
  final GetTvSeriesRecomen _getTVRecommendations;

  TvRecomenBloc(this._getTVRecommendations) : super(TVLoading()) {
    on<OnTVRecomen>((event, emit) async {
      final id = event.id;

      emit(TVLoading());
      final result = await _getTVRecommendations.execute(id);

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
  }
}

class WatchlistBloc extends Bloc<TVEvent, TVState> {
  final GetWatchlistTvSeriesStatus _getWatchlistTVs;
  final GetWatchListTvSeriesbyid _getWatchListStatus;
  final SaveWatchlistTvSeries _saveWatchlist;
  final RemoveWatchlistTvSeries _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistBloc(
    this._getWatchlistTVs,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(TVLoading()) {
    on<OnWatchlistTVs>((event, emit) async {
      emit(TVLoading());

      final result = await _getWatchlistTVs.execute();
      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVHasData(data)),
      );
    });
    on<OnWatchlistTvStatus>((event, emit) async {
      final id = event.id;
      emit(TVLoading());

      final result = await _getWatchListStatus.execute(id);
      emit(TVWatchlistStatus(result));
    });
    on<OnSaveWatchlistTv>((event, emit) async {
      final tv = event.tvDetail;
      emit(TVLoading());

      final result = await _saveWatchlist.execute(tv);
      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVWatchlistMessage(data)),
      );
    });
    on<OnRemoveWatchlistTv>((event, emit) async {
      final tv = event.tvDetail;
      emit(TVLoading());

      final result = await _removeWatchlist.execute(tv);
      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVWatchlistMessage(data)),
      );
    });
  }
}

class GetSeasonDetailTvBloc extends Bloc<TVEvent, TVState> {
  final GetSeasonDetailTv _getSeasonDetailTV;

  GetSeasonDetailTvBloc(this._getSeasonDetailTV) : super(TVLoading()) {
    on<OnSeasonTvDetail>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;

      emit(TVLoading());
      final result = await _getSeasonDetailTV.execute(id, seasonNumber);

      result.fold(
        (failure) => emit(TVError(failure.message)),
        (data) => emit(TVSeasonDetailHasData(data)),
      );
    });
  }
}
