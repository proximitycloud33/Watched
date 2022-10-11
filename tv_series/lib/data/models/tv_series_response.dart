import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/tv_series_model.dart';

class TVSeriesResponse extends Equatable {
  final List<TVSeriesModel> seriesList;
  const TVSeriesResponse({required this.seriesList});

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesResponse(
        seriesList: List<TVSeriesModel>.from((json["results"] as List)
            .map((x) => TVSeriesModel.fromJson(x))
            .where((element) => element.backdropPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(seriesList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [seriesList];
}
