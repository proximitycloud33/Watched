import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

extension on WidgetTester {
  // ignore: unused_element
  Future<void> pumpPopularMoviesPage(PopularMoviesBloc popularMoviesBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: popularMoviesBloc,
          child: const PopularMoviesPage(),
        ),
      ),
    );
  }
}

@GenerateMocks([PopularMoviesBloc])
void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
  });

  // Widget makeTestableWidget(Widget body) {
  //   return BlocProvider.value(
  //     value: mockPopularMoviesBloc,
  //     child: body,
  //   );
  // }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesState(
      popularMoviesRequestState: RequestState.loading,
    ));
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpPopularMoviesPage(mockPopularMoviesBloc);

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    // when(mockNotifier.state).thenReturn(RequestState.loaded);
    // when(mockNotifier.movies).thenReturn(<Movie>[]);

    when(() => mockPopularMoviesBloc.state).thenReturn(
      const PopularMoviesState(
        popularMoviesRequestState: RequestState.loaded,
        popularMovies: <Movie>[],
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpPopularMoviesPage(mockPopularMoviesBloc);

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    // when(mockNotifier.state).thenReturn(RequestState.error);
    // when(mockNotifier.message).thenReturn('Error message');
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesState(
      popularMoviesRequestState: RequestState.error,
      message: 'Error message',
    ));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpPopularMoviesPage(mockPopularMoviesBloc);

    expect(textFinder, findsOneWidget);
  });
}
