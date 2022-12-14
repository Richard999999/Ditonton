library movie;

// data
export 'package:movieseries/data/datasources/movie_local_data_source.dart';
export 'package:movieseries/data/datasources/movie_remote_data_source.dart';
export 'package:movieseries/data/models/movie_detail_model.dart';
export 'package:movieseries/data/models/movie_model.dart';
export 'package:movieseries/data/models/movie_response.dart';
export 'package:movieseries/data/models/movie_table.dart';
export 'package:movieseries/data/repositories/movie_repository_impl.dart';
export 'package:movieseries/domain/entities/movie.dart';
export 'package:movieseries/domain/entities/movie_detail.dart';
export 'package:movieseries/domain/repositories/movie_repository.dart';

// domain
export 'package:movieseries/domain/usecases/get_movie_detail.dart';
export 'package:movieseries/domain/usecases/get_movie_recommendations.dart';
export 'package:movieseries/domain/usecases/get_now_playing_movies.dart';
export 'package:movieseries/domain/entities/movie.dart';
export 'package:movieseries/domain/entities/movie_detail.dart';
export 'package:movieseries/domain/repositories/movie_repository.dart';
export 'package:movieseries/domain/usecases/get_popular_movies.dart';
export 'package:movieseries/domain/usecases/get_top_rated_movies.dart';
export 'package:movieseries/domain/usecases/get_watchlist_movie_status.dart';
export 'package:movieseries/domain/usecases/get_watchlist_movie_statusbyid.dart';
export 'package:movieseries/domain/usecases/save_watchlist_movie.dart';
export 'package:movieseries/domain/usecases/remove_watchlist_movie.dart';

// presentation
export 'package:movieseries/presentation/pages/home_movie_page.dart';
export 'package:movieseries/presentation/pages/movie_detail_page.dart';
export 'package:movieseries/presentation/pages/popular_movies_page.dart';
export 'package:movieseries/presentation/pages/top_rated_movies_page.dart';
export 'package:movieseries/presentation/pages/watchlist_page.dart';
export 'package:movieseries/presentation/widgets/movie_card_list.dart';
export 'package:movieseries/presentation/widgets/recomendations_movie_list.dart';
