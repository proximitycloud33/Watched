import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';

import '../../json_reader.dart';

void main() {
  const testTVSeriesModel = TVSeriesModel(
    backdropPath: "/Aa9TLpNpBMyRkD8sPJ7ACKLjt0l.jpg",
    firstAirDate: "2022-08-21",
    genreIds: [10765, 18, 10759],
    id: 94997,
    name: "House of the Dragon",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "House of the Dragon",
    overview:
        "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
    popularity: 6121.785,
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
    voteAverage: 8.6,
    voteCount: 1309,
  );
  const testTVSeriesResponseModel =
      TVSeriesResponse(seriesList: <TVSeriesModel>[testTVSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy/json/tv_series_on_the_air.json'));
      final result = TVSeriesResponse.fromJson(jsonMap);
      expect(result, testTVSeriesResponseModel);
    });
  });
  group('toJson', () {
    test('Should return a JSON map containing proper data', () async {
      final result = testTVSeriesResponseModel.toJson();
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/Aa9TLpNpBMyRkD8sPJ7ACKLjt0l.jpg",
            "first_air_date": "2022-08-21",
            "genre_ids": [10765, 18, 10759],
            "id": 94997,
            "name": "House of the Dragon",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "House of the Dragon",
            "overview":
                "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
            "popularity": 6121.785,
            "poster_path": "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
            "vote_average": 8.6,
            "vote_count": 1309
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
