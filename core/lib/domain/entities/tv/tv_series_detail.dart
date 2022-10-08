import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv/season.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  TVSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final String? posterPath;
  final List<Season> seasons;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props {
    return [
      adult,
      backdropPath,
      firstAirDate,
      genres,
      id,
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originalName,
      overview,
      posterPath,
      voteAverage,
      voteCount,
    ];
  }
}