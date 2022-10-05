import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetDetailTVSeries {
  final TVSeriesRepository repository;
  GetDetailTVSeries({required this.repository});

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getDetailTVSeries(id);
  }
}
