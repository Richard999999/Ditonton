import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';

class MockGetWatchlistTVsBloc extends MockBloc<TVEvent, TVState>
    implements WatchlistBloc {}

class TVStateFake extends Fake implements TVState {}

class MockGetDetailTvBloc extends MockBloc<TVEvent, TVState>
    implements TvSeriesDetailBloc {}

class TVEventFake extends Fake implements TVEvent {}

class MockGetPopularTvBloc extends MockBloc<TVEvent, TVState>
    implements PopularTvSeriesBloc {}

class MockGetTopRatedTVsBloc extends MockBloc<TVEvent, TVState>
    implements TopRatedTvSeriesBloc {}

class MockGetSeasonDetailTVBloc extends MockBloc<TVEvent, TVState>
    implements GetSeasonDetailTvBloc {}

class MockGetTvRecomenBloc extends MockBloc<TVEvent, TVState>
    implements TvRecomenBloc {}

class MockGetNowPlayTvBloc extends MockBloc<TVEvent, TVState>
    implements GetNowplaylist {}
