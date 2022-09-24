import 'package:equatable/equatable.dart';

import 'package:ditonton/data/models/movie/genre_model.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';

class TVSeriesDetailModel extends Equatable {
  TVSeriesDetailModel({
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
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdropPath': backdropPath,
      'firstAirDate': firstAirDate,
      'genres': genres.map((x) => x.toJson()).toList(),
      'id': id,
      'name': name,
      'numberOfEpisodes': numberOfEpisodes,
      'numberOfSeasons': numberOfSeasons,
      'originalName': originalName,
      'overview': overview,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  factory TVSeriesDetailModel.fromJson(Map<String, dynamic> json) {
    return TVSeriesDetailModel(
      adult: json['adult'],
      backdropPath: json['backdropPath'],
      firstAirDate: json['firstAirDate'],
      genres: List<GenreModel>.from(
          json['genres'].map((x) => GenreModel.fromJson(x))),
      id: json['id'],
      name: json['name'],
      numberOfEpisodes: json['numberOfEpisodes'],
      numberOfSeasons: json['numberOfSeasons'],
      originalName: json['originalName'],
      overview: json['overview'],
      posterPath: json['posterPath'],
      voteAverage: json['voteAverage'],
      voteCount: json['voteCount'],
    );
  }
  TVSeriesDetail toEntity() {
    return TVSeriesDetail(
      adult: this.adult,
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object> get props {
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
