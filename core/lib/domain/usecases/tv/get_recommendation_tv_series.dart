import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetRecommendationTVSeries {
  final TVSeriesRepository repository;
  GetRecommendationTVSeries({required this.repository});

  Future<Either<Failure, List<TVSeries>>> execute(int id) {
    return repository.getRecommendationTVSeries(id);
  }
}
