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
  final String posterPath;
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airDate': airDate,
      'episodes': episodes.map((x) => x.toJson()).toList(),
      'name': name,
      'overview': overview,
      'purpleId': purpleId,
      'posterPath': posterPath,
      'seasonNumber': seasonNumber,
    };
  }

  factory TVSeriesSeasonDetailModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesSeasonDetailModel(
      id: json['id'],
      airDate: json['airDate'],
      episodes: List<EpisodeModel>.from(
          json['episodes'].map((x) => EpisodeModel.fromJson(x))),
      name: json['name'],
      overview: json['overview'],
      purpleId: json['purpleId'],
      posterPath: json['posterPath'],
      seasonNumber: json['seasonNumber'],
    );
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
  List<Object> get props {
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
