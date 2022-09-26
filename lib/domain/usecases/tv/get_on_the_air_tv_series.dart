import 'package:dartz/dartz.dart';

import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

import '../../../common/failure.dart';

class GetOnTheAirTVSeries {
  final TVSeriesRepository repository;
  GetOnTheAirTVSeries({required this.repository});

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getOnTheAirTVSeries();
  }
}
