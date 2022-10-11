import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/provider/recommendation_tv_series_notifier.dart';

//TODO Change routes into seperate package || not in core;
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.Error) {
          return Text(data.message);
        } else if (data.state == RequestState.Loaded) {
          return SizedBox(
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
                        DETAIL_TV_ROUTE,
                        arguments: movie.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
