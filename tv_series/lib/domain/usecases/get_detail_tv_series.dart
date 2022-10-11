import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class GetDetailTVSeries {
  final TVSeriesRepository repository;
  GetDetailTVSeries({required this.repository});

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getDetailTVSeries(id);
  }
}
