library tvseries;

// data
export 'package:tvseries/data/datasources/tv_local_data_source.dart';
export 'package:tvseries/data/datasources/tv_remote_data_source.dart';
export 'package:tvseries/data/models/tv_detail_model.dart';
export 'package:tvseries/data/models/tv_model.dart';
export 'package:tvseries/data/models/tv_response.dart';
export 'package:tvseries/data/models/tv_table.dart';
export 'package:tvseries/data/repositories/tv_repository_impl.dart';
export 'package:tvseries/domain/entities/tv.dart';
export 'package:tvseries/domain/entities/tv_detail.dart';
export 'package:tvseries/domain/repositories/tv_repository.dart';
export 'package:tvseries/domain/usecases/get_noowplay_tv.dart';

// domain
export 'package:tvseries/domain/usecases/get_season_detail.dart';
export 'package:tvseries/domain/usecases/get_popular_tv.dart';
export 'package:tvseries/domain/usecases/get_top_rated_tv.dart';
export 'package:tvseries/domain/usecases/get_tv_detail.dart';
export 'package:tvseries/domain/usecases/get_tv_recomen.dart';
export 'package:tvseries/domain/usecases/get_watchlist_tv_statusbyid.dart';
export 'package:tvseries/domain/usecases/get_watchlist_tv_status.dart';
export 'package:tvseries/domain/usecases/remove_tv_watchlist.dart';
export 'package:tvseries/domain/usecases/save_tv_watchlist.dart';

// presentation
export 'package:tvseries/presentation/pages/now_playing_tv.dart';
export 'package:tvseries/presentation/pages/popular_tv_page.dart';
export 'package:tvseries/presentation/pages/top_rated_tv_page.dart';
export 'package:tvseries/presentation/pages/now_playing_tv.dart';
export 'package:tvseries/presentation/widgets/recomen_tv_list.dart';
export 'package:tvseries/presentation/widgets/tv_card_list.dart';
export 'package:tvseries/presentation/pages/detail_tv_page.dart';
export 'package:tvseries/presentation/pages/tv_series_page.dart';
