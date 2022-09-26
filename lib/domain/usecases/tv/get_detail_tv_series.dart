import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetDetailTVSeries {
  final TVSeriesRepository repository;
  GetDetailTVSeries({required this.repository});

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getDetailTVSeries(id);
  }
}
