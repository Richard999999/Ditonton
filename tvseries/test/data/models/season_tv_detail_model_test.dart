import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/season_detail_model.dart';

void main() {
  const tTVSeasonDetailModel = TVSeasonDetailModel(
    airDate: 'airDate',
    episodes: [],
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tTVSeasonDetailModelJson = {
    'air_date': 'airDate',
    'episodes': [],
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  test('should be a subclass of TV Series entity', () async {
    final result = tTVSeasonDetailModel.toJson();
    expect(result, tTVSeasonDetailModelJson);
  });
}
