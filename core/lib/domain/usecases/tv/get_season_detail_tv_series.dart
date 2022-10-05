import 'package:core/domain/entities/tv/tv_series_season_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetSeasonDetailTVSeries {
  final TVSeriesRepository repository;
  GetSeasonDetailTVSeries({required this.repository});

  Future<Either<Failure, TVSeriesSeasonDetail>> execute(int id, int season) {
    return repository.getSeasonDetailTVSeries(id, season);
  }
}
