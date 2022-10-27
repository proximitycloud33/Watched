import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/bloc/list_tv_series_bloc/list_tv_series_bloc.dart';

import 'mocks/list_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetOnTheAirTVSeries,
  GetPopularTVSeries,
  GetTopRatedTVSeries,
])
void main() {
  late ListTVSeriesBloc listTVSeriesBloc;
  late MockGetOnTheAirTVSeries mockGetOnTheAirTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetOnTheAirTVSeries = MockGetOnTheAirTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    listTVSeriesBloc = ListTVSeriesBloc(
      mockGetOnTheAirTVSeries,
      mockGetPopularTVSeries,
      mockGetTopRatedTVSeries,
    );
  });
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

  group('On The Air TVSeries', () {
    test('Starting state should be empty', () {
      expect(listTVSeriesBloc.state.onTheAirTVSeriesState, RequestState.empty);
    });
    blocTest<ListTVSeriesBloc, ListTVSeriesState>(
      'emits a new onTheAirTVSeries data when ListTVSeriesOnTheAirFetched is added.',
      setUp: () {
        when(mockGetOnTheAirTVSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTVSeriesList));
      },
      build: () => listTVSeriesBloc,
      act: (bloc) => bloc.add(ListTVSeriesOnTheAirFetched()),
      expect: () => <ListTVSeriesState>[
        const ListTVSeriesState(onTheAirTVSeriesState: RequestState.loading),
        ListTVSeriesState(
          onTheAirTVSeriesState: RequestState.loaded,
          onTheAirTVSeries: tTVSeriesList,
        )
      ],
    );
    blocTest<ListTVSeriesBloc, ListTVSeriesState>(
      'emits a new failure message data when ListTVSeriesOnTheAirFetched is added and failed.',
      setUp: () {
        when(mockGetOnTheAirTVSeries.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
      },
      build: () => listTVSeriesBloc,
      act: (bloc) => bloc.add(ListTVSeriesOnTheAirFetched()),
      expect: () => <ListTVSeriesState>[
        const ListTVSeriesState(onTheAirTVSeriesState: RequestState.loading),
        const ListTVSeriesState(
          onTheAirTVSeriesState: RequestState.error,
          message: 'Server Failure',
        )
      ],
    );
  });

  group('Popular TVSeries', () {
    test('Starting state should be empty', () {
      expect(listTVSeriesBloc.state.popularTVSeriesState, RequestState.empty);
    });
    blocTest<ListTVSeriesBloc, ListTVSeriesState>(
      'emits a new popularTVSeries data when ListTVSeriesPopularFetched is added.',
      setUp: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTVSeriesList));
      },
      build: () => listTVSeriesBloc,
      act: (bloc) => bloc.add(ListTVSeriesPopularFetched()),
      expect: () => <ListTVSeriesState>[
        const ListTVSeriesState(popularTVSeriesState: RequestState.loading),
        ListTVSeriesState(
          popularTVSeriesState: RequestState.loaded,
          popularTVSeries: tTVSeriesList,
        )
      ],
    );
    blocTest<ListTVSeriesBloc, ListTVSeriesState>(
      'emits a new failure message data when ListTVSeriesPopularFetched is added and failed.',
      setUp: () {
        when(mockGetPopularTVSeries.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
      },
      build: () => listTVSeriesBloc,
      act: (bloc) => bloc.add(ListTVSeriesPopularFetched()),
      expect: () => <ListTVSeriesState>[
        const ListTVSeriesState(popularTVSeriesState: RequestState.loading),
        const ListTVSeriesState(
          popularTVSeriesState: RequestState.error,
          message: 'Server Failure',
        )
      ],
    );
  });

  group('Top Rated TVSeries', () {
    test('Starting state should be empty', () {
      expect(listTVSeriesBloc.state.topRatedTVSeriesState, RequestState.empty);
    });
    blocTest<ListTVSeriesBloc, ListTVSeriesState>(
      'emits a new topRatedTVSeries data when ListTVSeriesTopRatedFetched is added.',
      setUp: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTVSeriesList));
      },
      build: () => listTVSeriesBloc,
      act: (bloc) => bloc.add(ListTVSeriesTopRatedFetched()),
      expect: () => <ListTVSeriesState>[
        const ListTVSeriesState(topRatedTVSeriesState: RequestState.loading),
        ListTVSeriesState(
          topRatedTVSeriesState: RequestState.loaded,
          topRatedTVSeries: tTVSeriesList,
        )
      ],
    );
    blocTest<ListTVSeriesBloc, ListTVSeriesState>(
      'emits a new failure message data when ListTVSeriesPopularFetched is added and failed.',
      setUp: () {
        when(mockGetTopRatedTVSeries.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
      },
      build: () => listTVSeriesBloc,
      act: (bloc) => bloc.add(ListTVSeriesTopRatedFetched()),
      expect: () => <ListTVSeriesState>[
        const ListTVSeriesState(topRatedTVSeriesState: RequestState.loading),
        const ListTVSeriesState(
          topRatedTVSeriesState: RequestState.error,
          message: 'Server Failure',
        )
      ],
    );
  });
}
