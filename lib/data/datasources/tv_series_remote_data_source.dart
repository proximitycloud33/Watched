import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_series_detail_response_model.dart';
import 'package:ditonton/data/models/tv/tv_series_model.dart';
import 'package:ditonton/data/models/tv/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getOnTheAirTVSeries();
  Future<List<TVSeriesModel>> getPopularTVSeries();
  Future<List<TVSeriesModel>> getTopRatedTVSeries();
  Future<TVSeriesDetailResponseModel> getDetailTVSeries(int id);
  Future<List<TVSeriesModel>> searchTVSeries(String query);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;
  TVSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVSeriesModel>> getOnTheAirTVSeries() async {
    final uri = '$BASE_URL/tv/on_the_air?$API_KEY';
    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getPopularTVSeries() async {
    final uri = '$BASE_URL/tv/popular?$API_KEY';
    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTopRatedTVSeries() async {
    final uri = '$BASE_URL/tv/top_rated?$API_KEY';
    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesDetailResponseModel> getDetailTVSeries(int id) {
    // TODO: implement getDetailTVSeries
    throw UnimplementedError();
  }

  @override
  Future<List<TVSeriesModel>> searchTVSeries(String query) {
    // TODO: implement searchTVSeries
    throw UnimplementedError();
  }
}
