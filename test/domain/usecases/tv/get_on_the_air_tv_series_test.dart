import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  late GetOnTheAirTVSeries usecase;
  late MockMovieRepository mockTVSeriesRepository;

  setUp(
    () {
      mockMovieRepository = MockMovieRepository();
      usecase = GetOnTheAirTVSeries(mockMovieRepository);
    },
  );
  final tTVSeries = <TVSeries>[];
  
      test('should get list of moview from repository', () {
        when(mockMovieRepository.getOnTheAirTVSeries()).thenAnswer((realInvocation) async =>  Right(tTVSeries));
      });
      final result = await usecase.execute(); 
      expect(result, Right(tTVSeries));
}
