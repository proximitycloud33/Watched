import 'package:core/styles/colors.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/detail_tv_series_bloc/detail_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/screen_arguments.dart';
import 'package:core/utils/routes.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailTVSeriesBloc, DetailTVSeriesState>(
      builder: (context, state) {
        if (state.tvSeriesDetailState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.tvSeriesDetailState == RequestState.error) {
          return Text(state.message);
        } else if (state.tvSeriesDetailState == RequestState.loaded) {
          int itemcount = state.tvSeriesDetail.seasons.length;
          return SizedBox(
            height: 75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemcount,
              itemBuilder: (context, index) {
                if (state.tvSeriesDetail.seasons[index].name == 'Specials') {
                  return Container();
                }
                final season = state.tvSeriesDetail.seasons[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        seasonDetailTVRoute,
                        arguments: ScreenArguments(
                          id: state.tvSeriesDetail.id,
                          seasonNumber: season.seasonNumber,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: Container(
                        color: kMikadoYellow,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              season.name,
                              style: const TextStyle(color: kRichBlack),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
