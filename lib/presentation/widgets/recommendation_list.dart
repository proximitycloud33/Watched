import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/recommendation_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList({
    Key? key,
    required this.recommendations,
  }) : super(key: key);

  final List<TVSeries> recommendations;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendationTVSeriesNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Error) {
          return Text(data.message);
        } else if (data.state == RequestState.Loaded) {
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TVSeriesDetailPage.ROUTE_NAME,
                        arguments: movie.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendations.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
