import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetRecommendationTVSeries {
  final TVSeriesRepository repository;
  GetRecommendationTVSeries({required this.repository});

  Future<Either<Failure, List<TVSeries>>> execute(int id) {
    return repository.getRecommendationTVSeries(id);
  }
}