import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

extension on WidgetTester {
  // ignore: unused_element
  Future<void> pumpPopularMoviesPage(TopRatedMoviesBloc topRatedMoviesBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: topRatedMoviesBloc,
          child: TopRatedMoviesPage(),
        ),
      ),
    );
  }
}

void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUp(() {
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state)
        .thenReturn(const TopRatedMoviesState(
      topRatedMoviesRequestState: RequestState.loading,
    ));

    await tester.pumpPopularMoviesPage(mockTopRatedMoviesBloc);
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state)
        .thenReturn(const TopRatedMoviesState(
      topRatedMoviesRequestState: RequestState.loaded,
      topRatedMovies: <Movie>[],
    ));

    await tester.pumpPopularMoviesPage(mockTopRatedMoviesBloc);

    final listViewFinder = find.byType(ListView);

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    // when(mockNotifier.state).thenReturn(RequestState.error);
    // when(mockNotifier.message).thenReturn('Error message');
    when(() => mockTopRatedMoviesBloc.state)
        .thenReturn(const TopRatedMoviesState(
      topRatedMoviesRequestState: RequestState.error,
      topRatedMovies: <Movie>[],
      message: 'Error message',
    ));
    await tester.pumpPopularMoviesPage(mockTopRatedMoviesBloc);

    final textFinder = find.byKey(const Key('error_message'));

    expect(textFinder, findsOneWidget);
  });
}
