import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockWatchlistCubit extends MockCubit<WatchlistState>
    implements WatchlistCubit {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

extension on WidgetTester {
  // ignore: unused_element
  Future<void> pumpMovieDetailPage(
    WatchlistCubit watchlistCubit,
    MovieDetailBloc movieDetailBloc,
  ) {
    return pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: watchlistCubit,
            ),
            BlocProvider.value(
              value: movieDetailBloc,
            ),
          ],
          child: const MovieDetailPage(id: 1),
        ),
      ),
    );
  }
}

void main() {
  late MockWatchlistCubit mockWatchlistCubit;
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUp(() {
    mockWatchlistCubit = MockWatchlistCubit();
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailState(
      movieState: RequestState.loaded,
      recommendationState: RequestState.loaded,
    ));
    when(() => mockWatchlistCubit.state).thenReturn(const WatchlistState(
      isAddedToWatchList: false,
    ));
    when(() => mockWatchlistCubit.loadWatchlistStatus(1)).thenAnswer(
      (invocation) async => false,
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpMovieDetailPage(mockWatchlistCubit, mockMovieDetailBloc);
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailState(
      movieState: RequestState.loaded,
      recommendationState: RequestState.loaded,
    ));
    when(() => mockWatchlistCubit.state).thenReturn(const WatchlistState(
      isAddedToWatchList: true,
    ));
    when(() => mockWatchlistCubit.loadWatchlistStatus(1)).thenAnswer(
      (invocation) async => true,
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);
    await tester.pumpMovieDetailPage(mockWatchlistCubit, mockMovieDetailBloc);

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailState(
      movieState: RequestState.loaded,
      recommendationState: RequestState.loaded,
    ));
    when(() => mockWatchlistCubit.state).thenReturn(const WatchlistState(
        isAddedToWatchList: false, watchlistMessage: 'Added to Watchlist'));
    when(() => mockWatchlistCubit.loadWatchlistStatus(1)).thenAnswer(
      (invocation) async => false,
    );
    when(() => mockWatchlistCubit.addWatchlist(testWatchlist))
        .thenAnswer((invocation) async {});

    await tester.pumpMovieDetailPage(mockWatchlistCubit, mockMovieDetailBloc);

    final watchlistButton = find.byType(ElevatedButton);
    expect(watchlistButton, findsOneWidget);

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump(const Duration(milliseconds: 150));
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailState(
      movieState: RequestState.loaded,
      recommendationState: RequestState.loaded,
    ));
    when(() => mockWatchlistCubit.state).thenReturn(const WatchlistState(
      isAddedToWatchList: false,
      failureMessage: 'Failed',
      watchlistMessage: 'Failed',
    ));
    when(() => mockWatchlistCubit.loadWatchlistStatus(1)).thenAnswer(
      (invocation) async => false,
    );
    when(() => mockWatchlistCubit.addWatchlist(testWatchlist))
        .thenAnswer((invocation) async {});

    await tester.pumpMovieDetailPage(mockWatchlistCubit, mockMovieDetailBloc);

    final watchlistButton = find.byType(ElevatedButton);
    expect(watchlistButton, findsOneWidget);

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump(const Duration(milliseconds: 150));

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
