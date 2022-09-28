import 'package:ditonton/domain/entities/tv/tv_series_season_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetSeasonDetailTVSeries {
  final TVSeriesRepository repository;
  GetSeasonDetailTVSeries(this.repository);

  Future<Either<Failure, TVSeriesSeasonDetail>> execute(int id, int season) {
    return repository.getSeasonDetailTVSeries(id, season);
  }
}
