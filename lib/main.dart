import '../core/lib/domain/entities/tv/episode.dart';
import '../core/lib/presentation/pages/tv/home_tv_series_page.dart';
import '../core/lib/presentation/pages/tv/popular_tv_series_page.dart';
import '../core/lib/presentation/pages/tv/screen_arguments.dart';
import '../core/lib/presentation/pages/tv/search_tv_series_page.dart';
import '../core/lib/presentation/pages/tv/top_rated_tv_series_page.dart';
import '../core/lib/presentation/pages/tv/tv_series_detail_page.dart';
import '../core/lib/presentation/pages/tv/tv_series_episode_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:about/about_page.dart';

import 'package:ditonton/injection.dart' as di;
import '../core/lib/presentation/pages/movie/home_movie_page.dart';
import '../core/lib/presentation/pages/movie/movie_detail_page.dart';
import '../core/lib/presentation/pages/movie/popular_movies_page.dart';
import '../core/lib/presentation/pages/movie/search_movies_page.dart';
import '../core/lib/presentation/pages/movie/top_rated_movies_page.dart';
import '../core/lib/presentation/pages/watchlist_page.dart';
import '../core/lib/presentation/provider/movie/movie_detail_notifier.dart';
import '../core/lib/presentation/provider/movie/movie_list_notifier.dart';
import '../core/lib/presentation/provider/movie/movie_search_notifier.dart';
import '../core/lib/presentation/provider/movie/popular_movies_notifier.dart';
import '../core/lib/presentation/provider/movie/top_rated_movies_notifier.dart';
import '../core/lib/presentation/provider/tv/detail_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/list_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/on_the_air_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/popular_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/recommendation_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/search_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/season_detail_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/top_rated_tv_series_notifier.dart';
import '../core/lib/presentation/provider/watchlist_notifier.dart';
import '../core/lib/presentation/pages/tv/tv_series_season_detail_page.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //* Movies
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),

        //* Watchlist
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
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
        ChangeNotifierProvider(
          create: (context) => di.locator<SearchTVSeriesNotifier>(),
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
