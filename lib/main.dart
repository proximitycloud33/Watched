import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/search_movies_page.dart';
import 'package:ditonton/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv/detail_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/list_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/on_the_air_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/popular_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/recommendation_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/search_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/season_detail_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_series_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Movies
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

        // Watchlist
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),

        // TV Series
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
            case '/home':
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
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
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
