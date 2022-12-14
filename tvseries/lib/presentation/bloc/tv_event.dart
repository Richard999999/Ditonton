part of 'tv_bloc.dart';

abstract class TVEvent extends Equatable {
  const TVEvent();

  @override
  List<Object> get props => [];
}

class OnAiringTodayTV extends TVEvent {}

class OnOnTheAirTV extends TVEvent {}

class OnPopularTV extends TVEvent {}

class OnTopRatedTV extends TVEvent {}

class OnTvDetail extends TVEvent {
  final int id;
  const OnTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnSeasonTvDetail extends TVEvent {
  final int id;
  final int seasonNumber;
  const OnSeasonTvDetail(this.id, this.seasonNumber);

  @override
  List<Object> get props => [id, seasonNumber];
}

class OnTVRecomen extends TVEvent {
  final int id;
  const OnTVRecomen(this.id);

  @override
  List<Object> get props => [id];
}

class OnWatchlistTVs extends TVEvent {}

class OnWatchlistTvStatus extends TVEvent {
  final int id;
  const OnWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveWatchlistTv extends TVEvent {
  final TvDetail tvDetail;
  const OnSaveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRemoveWatchlistTv extends TVEvent {
  final TvDetail tvDetail;
  const OnRemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
