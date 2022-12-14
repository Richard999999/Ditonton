import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import '../../dummy_data/tv/dummy_objects_tv.dart';

void main() {
  testWidgets('movie event', (tester) async {
    expect(const OnTvDetail(1) != const OnTvDetail(2), true);
    expect(const OnTVRecomen(1) != const OnTVRecomen(2), true);
    expect(const OnWatchlistTvStatus(1) != const OnWatchlistTvStatus(2), true);
    expect(
        const OnSaveWatchlistTv(testTVDetail) !=
            const OnSaveWatchlistTv(testTVDetailOrther),
        true);
    expect(
        const OnRemoveWatchlistTv(testTVDetail) !=
            const OnRemoveWatchlistTv(testTVDetailOrther),
        true);
    expect(const OnSeasonTvDetail(1, 1) != const OnSeasonTvDetail(2, 2), true);
  });
}
