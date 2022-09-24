import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv/tv_series.dart';

class TVSeriesModel extends Equatable {
  final String backdropPath;
  final String firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  TVSeriesModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'backdropPath': backdropPath,
      'firstAirDate': firstAirDate,
      'genreIds': genreIds,
      'id': id,
      'name': name,
      'originCountry': originCountry,
      'originalLanguage': originalLanguage,
      'originalName': originalName,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  factory TVSeriesModel.fromMap(Map<String, dynamic> json) {
    return TVSeriesModel(
      backdropPath: json['backdropPath'],
      firstAirDate: json['firstAirDate'],
      genreIds: List<int>.from(json['genreIds']),
      id: json['id'],
      name: json['name'],
      originCountry: List<String>.from(json['originCountry']),
      originalLanguage: json['originalLanguage'],
      originalName: json['originalName'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['posterPath'],
      voteAverage: json['voteAverage'],
      voteCount: json['voteCount'],
    );
  }
  TVSeries toEntity() {
    return TVSeries(
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genreIds: this.genreIds,
      id: this.id,
      name: this.name,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object> get props {
    return [
      backdropPath,
      firstAirDate,
      genreIds,
      id,
      name,
      originCountry,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      voteAverage,
      voteCount,
    ];
  }
}
