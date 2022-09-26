import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';

import '../../common/failure.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
}
