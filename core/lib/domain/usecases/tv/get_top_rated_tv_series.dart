import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTVSeries {
  final TVSeriesRepository repository;
  GetTopRatedTVSeries({required this.repository});

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getTopRatedTVSeries();
  }
}
