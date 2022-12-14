import 'dart:io';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../../../tvseries/test/dummy_data/tv/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteData mockTVRemoteDataSource;
  late MockTvLocalDataSource mockTVLocalDataSource;

  setUp(() {
    mockTVRemoteDataSource = MockTvRemoteData();
    mockTVLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockTVRemoteDataSource,
      tvlocalDataSource: mockTVLocalDataSource,
    );
  });

  const tvModel = TvModel(
      backdropPath: "/pdfCr8W0wBCpdjbZXSxnKhZtosP.jpg",
      genreIds: [10765, 10759, 18],
      id: 84773,
      name: "The Lord of the Rings: The Rings of Power",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "The Lord of the Rings: The Rings of Power",
      overview:
          "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
      popularity: 5975.998,
      posterPath: "/suyNxglk17Cpk8rCM2kZgqKdftk.jpg",
      voteAverage: 7.6,
      voteCount: 593);

  final tv = Tv(
      backdropPath: "/pdfCr8W0wBCpdjbZXSxnKhZtosP.jpg",
      genreIds: const [10765, 10759, 18],
      id: 84773,
      name: "The Lord of the Rings: The Rings of Power",
      originCountry: const ["US"],
      originalLanguage: "en",
      originalName: "The Lord of the Rings: The Rings of Power",
      overview:
          "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
      popularity: 5975.998,
      posterPath: "/suyNxglk17Cpk8rCM2kZgqKdftk.jpg",
      voteAverage: 7.6,
      voteCount: 593);

  final tvModelList = <TvModel>[tvModel];
  final tvList = <Tv>[tv];

  group('Now Playing on the Air Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getNowPlayingTv())
          .thenAnswer((_) async => tvModelList);
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockTVRemoteDataSource.getNowPlayingTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });
    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getNowPlayingTv())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockTVRemoteDataSource.getNowPlayingTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getNowPlayingTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTv();
      // assert
      verify(mockTVRemoteDataSource.getNowPlayingTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Series', () {
    test('should return TV Series list when call to data source is success',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getPopularTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return TV Series list when call to data source is successful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tvModelList);
      // act
      final result = await repository.getTopRatedTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTopRatedTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Series Detail', () {
    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTvDetail(tvId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tvId);
      // assert
      verify(mockTVRemoteDataSource.getTvDetail(tvId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTvDetail(tvId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tvId);
      // assert
      verify(mockTVRemoteDataSource.getTvDetail(tvId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Series Recommendations', () {
    const tId = 1;

    test('should return data (TV Series list) when the call is successful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTvRecommendation(tId))
          .thenAnswer((_) async => tvModelList);
      // act
      final result = await repository.getTvRecommendation(tId);
      // assert
      verify(mockTVRemoteDataSource.getTvRecommendation(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTvRecommendation(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendation(tId);
      // assertbuild runner
      verify(mockTVRemoteDataSource.getTvRecommendation(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.getTvRecommendation(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendation(tId);
      // assert
      verify(mockTVRemoteDataSource.getTvRecommendation(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach TV Series', () {
    const tQuery = 'the lord';

    test('should return TV Series list when call to data source is successful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tvModelList);
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTVRemoteDataSource.searchTv(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTVRemoteDataSource.searchTv(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTVLocalDataSource.insertWatchList(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.tvSaveWatchList(testTVDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTVLocalDataSource.insertWatchList(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.tvSaveWatchList(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTVLocalDataSource.removeWatchList(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.tvRemoveWatchlist(testTVDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTVLocalDataSource.removeWatchList(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.tvRemoveWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockTVLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isTvAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockTVLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
