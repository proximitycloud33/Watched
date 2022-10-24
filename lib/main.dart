import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:ditonton/simple_bloc_observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_presentation.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';
import 'package:about/about_page.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/tv_series_presentation.dart';
import 'package:watchlist/watchlist_presentation.dart';

void main() {
  di.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //* Movies
        BlocProvider(
          create: (_) => di.locator<MovieListBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchMoviesBloc>(),
        ),
        //* Watchlist
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistCubit>(),
        ),
        //* TV Series
        ChangeNotifierProvider(
          create: (context) => di.locator<ListTVSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<OnTheAirTVSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<PopularTVSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TopRatedTVSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<DetailTVSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<RecommendationTVSeriesNotifier>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchTVSeriesBloc>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<SeasonDetailTVSeriesNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            //* Movie
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            //* Misc
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            //* TVSeries
            case HomeTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTVSeriesPage());
            case PopularTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVSeriesPage());
            case TopRatedTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVSeriesPage());
            case TVSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TVSeriesDetailPage(id: id));
            case SearchTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchTVSeriesPage());
            case TVSeriesSeasonDetailPage.ROUTE_NAME:
              final args = settings.arguments as ScreenArguments;
              return MaterialPageRoute(
                  builder: (_) => TVSeriesSeasonDetailPage(
                      id: args.id, seasonNumber: args.seasonNumber));
            case TVSeriesEpisodeDetailPage.ROUTE_NAME:
              final episode = settings.arguments as Episode;
              return MaterialPageRoute(
                  builder: (context) =>
                      TVSeriesEpisodeDetailPage(episode: episode));
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
