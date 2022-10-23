import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:tv_series/data/models/tv_series_detail_response_model.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import 'package:tv_series/data/models/tv_series_season_detail_model.dart';

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getOnTheAirTVSeries();
  Future<List<TVSeriesModel>> getPopularTVSeries();
  Future<List<TVSeriesModel>> getTopRatedTVSeries();
  Future<TVSeriesDetailResponseModel> getDetailTVSeries(int id);
  Future<List<TVSeriesModel>> searchTVSeries(String query);
  Future<TVSeriesSeasonDetailModel> getSeasonDetailTVSeries(int id, int season);
  Future<List<TVSeriesModel>> getRecommendationTVSeries(int id);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  // final http.Client client;
  final IOClientWithSSL client;
  TVSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVSeriesModel>> getOnTheAirTVSeries() async {
    const uri = '$BASE_URL/tv/on_the_air?$API_KEY';
    final response = await client.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getPopularTVSeries() async {
    const uri = '$BASE_URL/tv/popular?$API_KEY';
    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTopRatedTVSeries() async {
    const uri = '$BASE_URL/tv/top_rated?$API_KEY';
    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesDetailResponseModel> getDetailTVSeries(int id) async {
    final uri = '$BASE_URL/tv/$id?$API_KEY';
    final response = await client.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return TVSeriesDetailResponseModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> searchTVSeries(String query) async {
    final uri = '$BASE_URL/search/tv/?$API_KEY&query=$query';
    final response = await client.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getRecommendationTVSeries(int id) async {
    final uri = '$BASE_URL/tv/$id/recommendations?$API_KEY';
    final response = await client.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesSeasonDetailModel> getSeasonDetailTVSeries(
      int id, int season) async {
    final uri = '$BASE_URL/tv/$id/season/$season?$API_KEY';
    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return TVSeriesSeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
