import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series_bloc/popular_tv_series_bloc.dart';

import 'mocks/popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late PopularTVSeriesBloc popularTVSeriesBloc;
  late MockGetPopularTVSeries mockGetPopularTVSeries;

  setUp(
    () {
      mockGetPopularTVSeries = MockGetPopularTVSeries();
      popularTVSeriesBloc = PopularTVSeriesBloc(mockGetPopularTVSeries);
    },
  );
  const tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalname',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'first',
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'en',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTVSeriesList = <TVSeries>[tTVSeries];
  group('OnTheAir TVSeries', () {
    blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'emits [state to loading and then change TV Series data and to loaded] when PopularTVSeriesFetched is added.',
      setUp: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTVSeriesList));
      },
      build: () => popularTVSeriesBloc,
      act: (bloc) => bloc.add(const PopularTVSeriesFetched()),
      expect: () => <PopularTVSeriesState>[
        const PopularTVSeriesState(
          popularTVSeriesRequestState: RequestState.loading,
        ),
        PopularTVSeriesState(
          popularTVSeriesRequestState: RequestState.loaded,
          popularTVSeries: tTVSeriesList,
        ),
      ],
    );
    blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'emits [state to empty with failure message] when PopularTVSeriesFetched is failed.',
      setUp: () {
        when(mockGetPopularTVSeries.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
      },
      build: () => popularTVSeriesBloc,
      act: (bloc) => bloc.add(const PopularTVSeriesFetched()),
      expect: () => <PopularTVSeriesState>[
        const PopularTVSeriesState(
          popularTVSeriesRequestState: RequestState.loading,
        ),
        const PopularTVSeriesState(
          popularTVSeriesRequestState: RequestState.error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
