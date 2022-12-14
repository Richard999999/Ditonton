import 'package:core/data/models/genre_model.dart';
import 'package:tvseries/data/models/season_tv_model.dart';
import 'package:tvseries/domain/entities/tv_detail.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
    //required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.firstAirDate,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    //required this.type,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
  });

  // final bool adult;
  final String firstAirDate;
  final String? backdropPath;
  final List<int> episodeRunTime;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String? name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String status;
  final String tagline;
  // final String type;
  final double voteAverage;
  final int voteCount;
  final List<TVSeasonModel> seasons;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        //  adult: json["adult"],
        backdropPath: json["backdrop_path"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        firstAirDate: json["first_air_date"],
        //  type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        seasons: List<TVSeasonModel>.from(
            json["seasons"].map((x) => TVSeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        //  "adult": adult,
        "backdrop_path": backdropPath,
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "status": status,
        "tagline": tagline,
        //"type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      };

  TvDetail toEntity() => TvDetail(
        //  adult: adult,
        backdropPath: backdropPath,
        episodeRuntime: episodeRunTime,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        id: id,
        name: name,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSessions: numberOfSeasons,
        originalName: originalName,
        overview: overview,
        //popularity: popularity,
        firstAirDate: firstAirDate,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
        seasons: seasons.map((season) => season.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        //   adult,
        backdropPath,
        episodeRunTime,
        genres,
        firstAirDate,
        homepage,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        //   type,
        voteAverage,
        voteCount,
        seasons,
      ];
}
