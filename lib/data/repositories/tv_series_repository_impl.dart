import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/entities/tv/tv_series_season_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final TVSeriesRemoteDataSource remoteDataSource;
  TVSeriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, TVSeriesDetail>> getDetailTVSeries(int id) async {
    try {
      final result = await remoteDataSource.getDetailTVSeries(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries() async {
    try {
      final result = await remoteDataSource.getOnTheAirTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to internet'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries() async {
    try {
      final result = await remoteDataSource.getPopularTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to internet'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getRecommendationTVSeries(
      int id) async {
    try {
      final result = await remoteDataSource.getRecommendationTVSeries(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to internet'));
    }
  }

  @override
  Future<Either<Failure, TVSeriesSeasonDetail>> getSeasonDetailTVSeries(
      int id, int season) async {
    try {
      final result = await remoteDataSource.getSeasonDetailTVSeries(id, season);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to internet'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to internet'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTVSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to internet'));
    }
  }
}
