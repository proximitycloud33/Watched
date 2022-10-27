import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:tv_series/domain/usecases/get_recommendation_tv_series.dart';
import 'package:tv_series/presentation/bloc/detail_tv_series_bloc/detail_tv_series_bloc.dart';

import 'mocks/detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetDetailTVSeries,
  GetRecommendationTVSeries,
])
void main() {
  late DetailTVSeriesBloc detailTVSeriesBloc;
  late MockGetDetailTVSeries mockGetDetailTVSeries;
  late MockGetRecommendationTVSeries mockGetRecommendationTVSeries;
  setUp(
    () {
      mockGetDetailTVSeries = MockGetDetailTVSeries();
      mockGetRecommendationTVSeries = MockGetRecommendationTVSeries();
      detailTVSeriesBloc = DetailTVSeriesBloc(
        mockGetDetailTVSeries,
        mockGetRecommendationTVSeries,
      );
    },
  );
  const testId = 1;

  const tTVSeriesDetail = TVSeriesDetail(
    adult: false,
    firstAirDate: '2022-08-21',
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'Dragon',
    originalName: 'House of Dragon',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    seasons: [
      Season(
        airDate: '2022-08-21',
        episodeCount: 10,
        id: 1,
        name: 'Dragon',
        overview: '',
        posterPath: '',
        seasonNumber: 1,
      )
    ],
    voteAverage: 1,
    voteCount: 1,
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
  group('TVSeries Detail', () {
    test('Starting state should empty', () {
      expect(detailTVSeriesBloc.state, const DetailTVSeriesState());
    });
    blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
      'emits [loading and loaded state in TVSeriesDetailState] when DetailTVSeriesFetched is added.',
      setUp: () {
        when(mockGetDetailTVSeries.execute(testId))
            .thenAnswer((realInvocation) async => const Right(tTVSeriesDetail));
      },
      build: () => detailTVSeriesBloc,
      act: (bloc) => bloc.add(const DetailTVSeriesFetched(id: testId)),
      expect: () => <DetailTVSeriesState>[
        const DetailTVSeriesState(tvSeriesDetailState: RequestState.loading),
        const DetailTVSeriesState(
          tvSeriesDetailState: RequestState.loaded,
          tvSeriesDetail: tTVSeriesDetail,
        )
      ],
    );
    blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
      'emits [loading and error state in TVSeriesDetailState] when DetailTVSeriesFetched is added and failed.',
      setUp: () {
        when(mockGetDetailTVSeries.execute(testId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
      },
      build: () => detailTVSeriesBloc,
      act: (bloc) => bloc.add(const DetailTVSeriesFetched(id: testId)),
      expect: () => <DetailTVSeriesState>[
        const DetailTVSeriesState(tvSeriesDetailState: RequestState.loading),
        const DetailTVSeriesState(
          tvSeriesDetailState: RequestState.error,
          message: 'Server Failure',
        )
      ],
    );
  });
  group('TVSeries Recommendation', () {
    blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
      'emits [loading and loaded state in TVSeriesRecommendationState] when DetailTVSeriesRecommendationFetched is added.',
      setUp: () {
        when(mockGetRecommendationTVSeries.execute(testId))
            .thenAnswer((realInvocation) async => Right(tTVSeriesList));
      },
      build: () => detailTVSeriesBloc,
      act: (bloc) =>
          bloc.add(const DetailTVSeriesRecommendationFetched(id: testId)),
      expect: () => <DetailTVSeriesState>[
        const DetailTVSeriesState(
          recommendationState: RequestState.loading,
        ),
        DetailTVSeriesState(
          recommendationState: RequestState.loaded,
          tvSeriesRecommendations: tTVSeriesList,
        )
      ],
    );
    blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
      'emits [loading and error state in TVSeriesRecommendationState] when DetailTVSeriesRecommendationFetched is added and failed.',
      setUp: () {
        when(mockGetRecommendationTVSeries.execute(testId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
      },
      build: () => detailTVSeriesBloc,
      act: (bloc) =>
          bloc.add(const DetailTVSeriesRecommendationFetched(id: testId)),
      expect: () => <DetailTVSeriesState>[
        const DetailTVSeriesState(
          recommendationState: RequestState.loading,
        ),
        const DetailTVSeriesState(
          recommendationState: RequestState.error,
          message: 'Server Failure',
        )
      ],
    );
  });
}
