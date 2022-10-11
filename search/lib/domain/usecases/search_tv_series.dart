import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class SearchTVSeries {
  final TVSeriesRepository repository;

  SearchTVSeries({required this.repository});

  Future<Either<Failure, List<TVSeries>>> execute(String query) {
    return repository.searchTVSeries(query);
  }
}
