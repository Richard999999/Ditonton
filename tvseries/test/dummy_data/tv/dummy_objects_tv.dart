import 'package:core/data/models/genre_model.dart';
import 'package:tvseries/data/models/episode_tv_model.dart';
import 'package:tvseries/data/models/season_tv_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tvseries/domain/entities/tv_episode.dart';
import 'package:tvseries/domain/entities/tv_season.dart';
import 'package:tvseries/domain/entities/tv_season_detail.dart';
import 'package:tvseries/tvseries.dart';

final testTv = Tv(
    backdropPath: "backdropPath",
    genreIds: const [1, 2, 3],
    id: 1,
    name: "name",
    originCountry: const ["originalCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.0,
    posterPath: "posterPath",
    voteAverage: 1.0,
    voteCount: 1);

final testTvList = <Tv>[testTv];

const tvId = 1;

const testTVDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  numberOfEpisodes: 1,
  numberOfSessions: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [],
  firstAirDate: 'firstAirDate',
  episodeRuntime: [1, 2],
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

const testTVDetailOrther = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  numberOfEpisodes: 1,
  numberOfSessions: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [testTVSeason],
  firstAirDate: 'firstAirDate',
  episodeRuntime: [1],
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

const testTVDetailResponse = TvDetailResponse(
  backdropPath: 'backdropPath',
  episodeRunTime: [1, 2],
  genres: [GenreModel(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 1,
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  firstAirDate: 'firstAirDate',
  popularity: 1.0,
  posterPath: 'posterPath',
  status: 'status',
  tagline: 'tagline',
  voteAverage: 1.0,
  voteCount: 1,
  seasons: [],
);

final testTVDetailResponseJson = {
  "backdrop_path": 'backdropPath',
  'episode_run_time': [1, 2],
  'genres': [
    {
      'id': 1,
      'name': 'Action',
    }
  ],
  'homepage': 'homepage',
  'id': 1,
  'name': 'name',
  'number_of_episodes': 1,
  'number_of_seasons': 1,
  'original_name': 'originalName',
  'overview': 'overview',
  'first_air_date': 'firstAirDate',
  'popularity': 1.0,
  'poster_path': 'posterPath',
  'status': 'status',
  'tagline': 'tagline',
  'vote_average': 1.0,
  'vote_count': 1,
  'seasons': [],
};

final testWatchlistTv = Tv.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);
final testTVSeasonModelJson = {
  'air_date': 'airDate',
  'episode_count': 1,
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'poster_path': 'posterPath',
  'season_number': 1,
};

final testTVTableJson = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};

const testTvTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTVEpisode = TVEpisode(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'episode name',
  overview: 'overview',
  runtime: 10,
  seasonNumber: 1,
  showId: 1,
  stillPath: 'stillPath',
  voteAverage: 1.0,
  voteCount: 1,
);
const testTVSeason = Season(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);
final List<Season> testTVSeasonList = [testTVSeason];

const testTVSeasonModel = TVSeasonModel(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);
const testTVSeasonDetail = TVSeasonDetail(
  airDate: 'airDate',
  episodes: [testTVEpisode],
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

final testTvMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};

final testTVEpisodeModelJson = {
  'air_date': 'airDate',
  'episode_number': 1,
  'id': 1,
  'name': 'episode name',
  'overview': 'overview',
  'runtime': 10,
  'season_number': 1,
  'show_id': 1,
  'still_path': 'stillPath',
  'vote_average': 1.0,
  'vote_count': 1,
};

const testTVEpisodeModel = TVEpisodeModel(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'episode name',
  overview: 'overview',
  runtime: 10,
  seasonNumber: 1,
  showId: 1,
  stillPath: 'stillPath',
  voteAverage: 1.0,
  voteCount: 1,
);

const testTVEpisodeModel2 = TVEpisodeModel(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'episode name',
  overview: 'overview',
  runtime: 100,
  seasonNumber: 1,
  showId: 1,
  stillPath: 'stillPath',
  voteAverage: 1.0,
  voteCount: 1,
);
