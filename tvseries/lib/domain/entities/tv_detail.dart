import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv_season.dart';

class TvDetail extends Equatable {
  const TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.numberOfEpisodes,
    required this.numberOfSessions,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.firstAirDate,
    required this.episodeRuntime,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final int numberOfEpisodes;
  final int numberOfSessions;
  final String overview;
  final String? posterPath;
  final List<Season> seasons;
  final String firstAirDate;
  final List<int> episodeRuntime;
  final String? name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        numberOfEpisodes,
        numberOfSessions,
        overview,
        posterPath,
        seasons,
        firstAirDate,
        episodeRuntime,
        name,
        voteAverage,
        voteCount,
      ];
}
