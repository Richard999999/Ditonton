import 'package:movieseries/movieseries.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:movieseries/presentation/bloc/movie_bloc.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';
import 'package:search/search.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  IOClient ioClient = await SSLPinning.ioClient;

  //STATE MANAGEMENT BLOC
  locator.registerFactory(
    () => PlayingNowMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => RecommendationMovieBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMovieBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  //TV
  locator.registerFactory(
    () => TvRecomenBloc(locator()),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTVBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => GetNowplaylist(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // usecase
  // Movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SaveWachListMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovieStatus(locator()));
  locator.registerLazySingleton(() => GetWatchListMovieStatusByid(locator()));

  // Tv
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvDetailSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecomen(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeriesbyid(locator()));
  locator.registerLazySingleton(() => GetNoowPlay(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      tvlocalDataSource: locator(),
    ),
  );

  // data sources
  // Movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // Tv
  locator.registerLazySingleton<TvRemoteData>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(tvDatabaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => ioClient);
}
