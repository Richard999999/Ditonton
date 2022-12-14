import 'dart:convert';
import 'package:core/core.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:http/io_client.dart';
import 'package:tvseries/data/datasources/tv_remote_data_source.dart';
import 'package:tvseries/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../../core/test/json_reader.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  const API_KEY = 'api_key=30b54b9973098b7ac41074ae1dc9c54e';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TV', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/now_on_air_tv.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/now_on_air_tv.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTv();
      // assert
      expect(result, equals(tvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TV', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_popular.json')))
        .tvList;

    test('should return list of tv when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/tv_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTv();
      // assert
      expect(result, tvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_top_rated.json')))
        .tvList;

    test('should return list of TV when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/tv_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTv();
      // assert
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    const tId = 1;

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_recommendations.json')))
        .tvList;
    const tId = 1;

    test('should return list of tv Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvRecommendation(tId);
      // assert
      expect(result, equals(tvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendation(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TV Series', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv/search_tv.json')))
        .tvList;
    const tQuery = 'the lord';

    test('should return list of tv when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/search_tv.json'), 200));
      // act
      final result = await dataSource.searchTv(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTv(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
