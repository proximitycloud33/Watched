import 'dart:convert';

import '../../../../core/lib/data/models/tv/episode_model.dart';
import '../../../../core/lib/data/models/tv/tv_series_season_detail_model.dart';
import '../../../../core/lib/domain/entities/tv/episode.dart';
import '../../../../core/lib/domain/entities/tv/tv_series_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final testTVSeriesSeasonDetailModel = TVSeriesSeasonDetailModel(
    airDate: "2022-08-21",
    episodes: [
      EpisodeModel(
        airDate: "2022-08-21",
        episodeNumber: 1,
        id: 1971015,
        name: "The Heirs of the Dragon",
        overview:
            "Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.",
        productionCode: "",
        runtime: 66,
        seasonNumber: 1,
        showId: 94997,
        stillPath: "/7gHqMO96iyTEBh6fCL3GUHxbhKZ.jpg",
        voteAverage: 8,
        voteCount: 57,
      ),
    ],
    name: "Season 1",
    id: "5db952cca1d3320014e91171",
    purpleId: 134965,
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
    overview: "",
    seasonNumber: 1,
  );
  final testTVSeriesSeasonDetail = TVSeriesSeasonDetail(
    airDate: "2022-08-21",
    episodes: [
      Episode(
        airDate: "2022-08-21",
        episodeNumber: 1,
        id: 1971015,
        name: "The Heirs of the Dragon",
        overview:
            "Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.",
        productionCode: "",
        runtime: 66,
        seasonNumber: 1,
        showId: 94997,
        stillPath: "/7gHqMO96iyTEBh6fCL3GUHxbhKZ.jpg",
        voteAverage: 8,
        voteCount: 57,
      ),
    ],
    name: "Season 1",
    id: "5db952cca1d3320014e91171",
    purpleId: 134965,
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
    overview: "",
    seasonNumber: 1,
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/tv_series_season_detail.json'));
      final result = TVSeriesSeasonDetailModel.fromJson(jsonMap);
      expect(result, testTVSeriesSeasonDetailModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTVSeriesSeasonDetailModel.toJson();
      // assert
      final expectedJsonMap = {
        "_id": "5db952cca1d3320014e91171",
        "air_date": "2022-08-21",
        "episodes": [
          {
            "air_date": "2022-08-21",
            "episode_number": 1,
            "id": 1971015,
            "name": "The Heirs of the Dragon",
            "overview":
                "Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.",
            "production_code": "",
            "runtime": 66,
            "season_number": 1,
            "show_id": 94997,
            "still_path": "/7gHqMO96iyTEBh6fCL3GUHxbhKZ.jpg",
            "vote_average": 8,
            "vote_count": 57
          }
        ],
        "name": "Season 1",
        "overview": "",
        "id": 134965,
        "poster_path": "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
        "season_number": 1
      };
      expect(result, expectedJsonMap);
    });
  });
  group('To entity', () {
    test('should be a subclass of TVSeriesSeasonDetail entity', () {
      final result = testTVSeriesSeasonDetailModel.toEntity();
      expect(result, testTVSeriesSeasonDetail);
    });
  });
}
