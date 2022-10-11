import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class GetRecommendationTVSeries {
  final TVSeriesRepository repository;
  GetRecommendationTVSeries({required this.repository});

  Future<Either<Failure, List<TVSeries>>> execute(int id) {
    return repository.getRecommendationTVSeries(id);
  }
}
