import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv/episode.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int runtime;
  final int seasonNumber;
  final int showId;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      airDate: json['airDate'],
      episodeNumber: json['episodeNumber'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      productionCode: json['productionCode'],
      runtime: json['runtime'],
      seasonNumber: json['seasonNumber'],
      showId: json['showId'],
      stillPath: json['stillPath'],
      voteAverage: json['voteAverage'],
      voteCount: json['voteCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'airDate': airDate,
      'episodeNumber': episodeNumber,
      'id': id,
      'name': name,
      'overview': overview,
      'productionCode': productionCode,
      'runtime': runtime,
      'seasonNumber': seasonNumber,
      'showId': showId,
      'stillPath': stillPath,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  Episode toEntity() {
    return Episode(
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      id: this.id,
      name: this.name,
      overview: this.overview,
      productionCode: this.productionCode,
      runtime: this.runtime,
      seasonNumber: this.seasonNumber,
      showId: this.showId,
      stillPath: this.stillPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object> get props {
    return [
      airDate,
      episodeNumber,
      id,
      name,
      overview,
      productionCode,
      runtime,
      seasonNumber,
      showId,
      stillPath,
      voteAverage,
      voteCount,
    ];
  }
}
