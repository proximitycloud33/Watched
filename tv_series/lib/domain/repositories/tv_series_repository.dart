import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/entities/tv_series_season_detail.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries();
  Future<Either<Failure, TVSeriesDetail>> getDetailTVSeries(int id);
  Future<Either<Failure, List<TVSeries>>> getRecommendationTVSeries(int id);
  Future<Either<Failure, TVSeriesSeasonDetail>> getSeasonDetailTVSeries(
      int id, int season);
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
}
