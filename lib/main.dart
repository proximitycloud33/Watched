import 'package:about/about_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie_presentation.dart';
import 'package:search/search.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/tv_series_presentation.dart';
import 'package:watchlist/watchlist_presentation.dart';

import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/simple_bloc_observer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  di.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //* Movies
        BlocProvider(
          create: (_) => di.locator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchMoviesBloc>(),
        ),
        //* Watchlist
        BlocProvider(
          create: (_) => di.locator<WatchlistCubit>(),
        ),
        //* TV Series
        BlocProvider(
          create: (_) => di.locator<ListTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeasonDetailTVSeriesBloc>(),
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
            case homeMovieRoute:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case popularMovieRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMovieRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchMovieRoute:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            //* Misc
            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            //* TVSeries
            case homeTVRoute:
              return MaterialPageRoute(builder: (_) => HomeTVSeriesPage());
            case popularTVRoute:
              return CupertinoPageRoute(builder: (_) => PopularTVSeriesPage());
            case topRatedTVRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedTVSeriesPage());
            case detailTVRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TVSeriesDetailPage(id: id));
            case searchTVRoute:
              return MaterialPageRoute(builder: (_) => SearchTVSeriesPage());
            case seasonDetailTVRoute:
              final args = settings.arguments as ScreenArguments;
              return MaterialPageRoute(
                  builder: (_) => TVSeriesSeasonDetailPage(
                      id: args.id, seasonNumber: args.seasonNumber));
            case episodeDetailTVRoute:
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
