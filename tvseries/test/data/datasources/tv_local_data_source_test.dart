import 'package:core/core.dart';
import 'package:tvseries/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../tvseries/test/dummy_data/tv/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSourceTv;
  late MockDatabaseHelper mockDatabaseHelperTv;

  setUp(() {
    mockDatabaseHelperTv = MockDatabaseHelper();
    dataSourceTv =
        TvLocalDataSourceImpl(tvDatabaseHelper: mockDatabaseHelperTv);
  });

  group('save watchlist TV Series', () {
    test(
        'should return success message when insert to tv series database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchListTV(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceTv.insertWatchList(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test(
        'should throw DatabaseException when insert to TV Series database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchListTV(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceTv.insertWatchList(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist TV Series', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlistTV(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourceTv.removeWatchList(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlistTV(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceTv.removeWatchList(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Series Detail By Id', () {
    final tId = 1;

    test('should return Tv Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTVById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSourceTv.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSourceTv.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist TV Series', () {
    test('should return list of Tv Series Table from database', () async {
      // arrange
      when(mockDatabaseHelperTv.getWatchlistTVs())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSourceTv.getWatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
