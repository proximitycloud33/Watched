import 'package:core/domain/entities/tv/episode.dart';
import 'package:equatable/equatable.dart';

class TVSeriesSeasonDetail extends Equatable {
  const TVSeriesSeasonDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.purpleId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final String airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int purpleId;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props {
    return [
      id,
      airDate,
      episodes,
      name,
      overview,
      purpleId,
      posterPath,
      seasonNumber,
    ];
  }
}
