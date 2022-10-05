import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetPopularTVSeries {
  final TVSeriesRepository repository;
  GetPopularTVSeries({required this.repository});

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getPopularTVSeries();
  }
}
