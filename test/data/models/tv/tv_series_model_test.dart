import '../../../../core/lib/data/models/tv/tv_series_model.dart';
import '../../../../core/lib/domain/entities/tv/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testTVSeriesModel = TVSeriesModel(
    backdropPath: 'path',
    firstAirDate: 'date',
    genreIds: [4, 2, 0],
    id: 42,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'oriName',
    overview: 'overview',
    popularity: 42,
    posterPath: 'path',
    name: 'name',
    voteAverage: 4,
    voteCount: 2,
  );
  final testTVSeries = TVSeries(
    backdropPath: 'path',
    firstAirDate: 'date',
    genreIds: [4, 2, 0],
    id: 42,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'oriName',
    overview: 'overview',
    popularity: 42,
    posterPath: 'path',
    name: 'name',
    voteAverage: 4,
    voteCount: 2,
  );
  test('should be a subclass of Movie entity', () {
    final result = testTVSeriesModel.toEntity();
    expect(result, testTVSeries);
  });
}
