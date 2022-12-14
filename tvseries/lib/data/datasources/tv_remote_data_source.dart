import 'dart:convert';
import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/data/models/season_detail_model.dart';
import 'package:tvseries/tvseries.dart';

abstract class TvRemoteData {
  Future<List<TvModel>> getNowPlayingTv();
  Future<List<TvModel>> getPopularTv();
  Future<List<TvModel>> getTopRatedTv();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendation(int id);
  Future<List<TvModel>> searchTv(String query);
  Future<List<TvModel>> getNoowPlay();
  Future<TVSeasonDetailModel> getSeasonDetailTV(int id, int seasonNumber);
}

class TvRemoteDataSourceImpl implements TvRemoteData {
  static const API_KEY = 'api_key=30b54b9973098b7ac41074ae1dc9c54e';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final IOClient client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getNoowPlay() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getNowPlayingTv() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeasonDetailModel> getSeasonTv(int id, int numSeason) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/season/$numSeason?$API_KEY'));
    if (response.statusCode == 200) {
      return TVSeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendation(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeasonDetailModel> getSeasonDetailTV(
      int id, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return TVSeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
