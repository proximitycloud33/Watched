import 'dart:convert';
import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/data/models/tv_series_detail_response_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import 'package:tv_series/data/models/tv_series_season_detail_model.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';
  late TVSeriesRemoteDataSourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });
  group('Get On The Air TV Series', () {
    const uri = '$BASE_URL/tv/on_the_air?$API_KEY';
    const path = 'dummy/json/tv_series_on_the_air.json';
    final testTVSeriesList =
        TVSeriesResponse.fromJson(json.decode(readJson(path))).seriesList;
    test('Should return list of TV Series model when the response is OK (200)',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response(readJson(path), 200));
      final result = await datasource.getOnTheAirTVSeries();
      expect(result, equals(testTVSeriesList));
    });
    test('Should return Server Exception when the response is 404 or etc',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response('Not Found', 404));
      final call = datasource.getOnTheAirTVSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular TV Series', () {
    const uri = '$BASE_URL/tv/popular?$API_KEY';
    const path = 'dummy/json/tv_series_popular.json';
    final testTVSeriesList =
        TVSeriesResponse.fromJson(json.decode(readJson(path))).seriesList;
    test('Should return list of TV Series model when the response is OK (200)',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response(readJson(path), 200));
      final result = await datasource.getPopularTVSeries();
      expect(result, equals(testTVSeriesList));
    });
    test('Should return Server Exception when the response is 404 or etc',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response('Not Found', 404));
      final call = datasource.getPopularTVSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated TV Series', () {
    const uri = '$BASE_URL/tv/top_rated?$API_KEY';
    const path = 'dummy/json/tv_series_top_rated.json';
    final testTVSeriesList =
        TVSeriesResponse.fromJson(json.decode(readJson(path))).seriesList;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    };
    test('Should return list of TV Series model when the response is OK (200)',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async =>
              http.Response(readJson(path), 200, headers: headers));
      final result = await datasource.getTopRatedTVSeries();
      expect(result, equals(testTVSeriesList));
    });
    test('Should return Server Exception when the response is 404 or etc',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response('Not Found', 404));
      final call = datasource.getTopRatedTVSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Detail TV Series', () {
    const testId = 1;
    const uri = '$BASE_URL/tv/$testId?$API_KEY';
    const path = 'dummy/json/tv_series_detail.json';
    final testTVSeriesDetail =
        TVSeriesDetailResponseModel.fromJson(json.decode(readJson(path)));

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    };
    test('Should return Detail TV Series model when the response is OK (200)',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async =>
              http.Response(readJson(path), 200, headers: headers));
      final result = await datasource.getDetailTVSeries(testId);
      expect(result, equals(testTVSeriesDetail));
    });
    test('Should return Server Exception when the response is 404 or etc',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response('Not Found', 404));
      final call = datasource.getDetailTVSeries(testId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search TV Series', () {
    const query = 'query';
    const uri = '$BASE_URL/search/tv/?$API_KEY&query=$query';
    const path = 'dummy/json/tv_series_search.json';
    final testSearchResult =
        TVSeriesResponse.fromJson(json.decode(readJson(path))).seriesList;

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    };
    test('Should return list of TV Series model when the response is OK (200)',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async =>
              http.Response(readJson(path), 200, headers: headers));
      final result = await datasource.searchTVSeries(query);
      expect(result, equals(testSearchResult));
    });
    test('Should return Server Exception when the response is 404 or etc',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response('Not Found', 404));
      final call = datasource.searchTVSeries(query);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('Recommendation TV Series', () {
    const testId = 1;
    const uri = '$BASE_URL/tv/$testId/recommendations?$API_KEY';
    const path = 'dummy/json/tv_series_recommendation.json';
    final testTVSeriesList =
        TVSeriesResponse.fromJson(json.decode(readJson(path))).seriesList;

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    };
    test('Should return list of TV Series model when the response is OK (200)',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async =>
              http.Response(readJson(path), 200, headers: headers));
      final result = await datasource.getRecommendationTVSeries(testId);
      expect(result, equals(testTVSeriesList));
    });
    test('Should return Server Exception when the response is 404 or etc',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response('Not Found', 404));
      final call = datasource.getRecommendationTVSeries(testId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('Season Detail TV Series', () {
    const testId = 1;
    const testSeason = 1;
    const uri = '$BASE_URL/tv/$testId/season/$testSeason?$API_KEY';
    const path = 'dummy/json/tv_series_season_detail.json';
    final testTVSeriesSeasonDetail =
        TVSeriesSeasonDetailModel.fromJson(json.decode(readJson(path)));

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    };
    test('Should return list of TV Series model when the response is OK (200)',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async =>
              http.Response(readJson(path), 200, headers: headers));
      final result =
          await datasource.getSeasonDetailTVSeries(testId, testSeason);
      expect(result, equals(testTVSeriesSeasonDetail));
    });
    test('Should return Server Exception when the response is 404 or etc',
        () async {
      when(mockHttpClient.get(Uri.parse(uri))).thenAnswer(
          (realInvocation) async => http.Response('Not Found', 404));
      final call = datasource.getSeasonDetailTVSeries(testId, testSeason);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
