import 'package:core/styles/colors.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/pages/screen_arguments.dart';
import 'package:tv_series/presentation/pages/tv_series_season_detail_page.dart';
import 'package:tv_series/presentation/provider/detail_tv_series_notifier.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailTVSeriesNotifier>(
      builder: (context, data, child) {
        if (data.tvSeriesState == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.tvSeriesState == RequestState.Error) {
          return Text(data.message);
        } else if (data.tvSeriesState == RequestState.Loaded) {
          int itemcount = data.tvSeriesDetail.seasons.length;
          return SizedBox(
            height: 75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemcount,
              itemBuilder: (context, index) {
                if (data.tvSeriesDetail.seasons[index].name == 'Specials') {
                  return Container();
                }
                final season = data.tvSeriesDetail.seasons[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TVSeriesSeasonDetailPage.ROUTE_NAME,
                        arguments: ScreenArguments(
                          id: data.tvSeriesDetail.id,
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
