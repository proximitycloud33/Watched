import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class GetSeasonDetailTVSeries {
  final TVSeriesRepository repository;
  GetSeasonDetailTVSeries({required this.repository});

  Future<Either<Failure, TVSeriesSeasonDetail>> execute(int id, int season) {
    return repository.getSeasonDetailTVSeries(id, season);
  }
}
