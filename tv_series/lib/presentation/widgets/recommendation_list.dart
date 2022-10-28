import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/detail_tv_series_bloc/detail_tv_series_bloc.dart';

class RecommendationList extends StatelessWidget {
  const RecommendationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailTVSeriesBloc, DetailTVSeriesState>(
      builder: (context, state) {
        if (state.recommendationState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.recommendationState == RequestState.error) {
          return Text(state.message);
        } else if (state.recommendationState == RequestState.loaded) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = state.tvSeriesRecommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        detailTVRoute,
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
              itemCount: state.tvSeriesRecommendations.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
