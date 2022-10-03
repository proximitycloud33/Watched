import 'package:equatable/equatable.dart';

import 'package:ditonton/data/models/tv/episode_model.dart';
import 'package:ditonton/domain/entities/tv/tv_series_season_detail.dart';

class TVSeriesSeasonDetailModel extends Equatable {
  final String id;
  final String airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int purpleId;
  final String? posterPath;
  final int seasonNumber;

  TVSeriesSeasonDetailModel({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.purpleId,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory TVSeriesSeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      TVSeriesSeasonDetailModel(
        id: json['_id'],
        airDate: json['air_date'] ?? '',
        episodes: List<EpisodeModel>.from(
            json['episodes'].map((x) => EpisodeModel.fromJson(x))),
        name: json['name'],
        overview: json['overview'],
        purpleId: json['id'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
      );

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'air_date': airDate,
      'episodes': episodes.map((x) => x.toJson()).toList(),
      'name': name,
      'overview': overview,
      'id': purpleId,
      'poster_path': posterPath,
      'season_number': seasonNumber,
    };
  }

  TVSeriesSeasonDetail toEntity() {
    return TVSeriesSeasonDetail(
      id: this.id,
      airDate: this.airDate,
      episodes: this.episodes.map((episode) => episode.toEntity()).toList(),
      name: this.name,
      overview: this.overview,
      purpleId: this.purpleId,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

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
