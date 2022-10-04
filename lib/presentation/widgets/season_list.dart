import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/tv/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_season_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/detail_tv_series_notifier.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailTVSeriesNotifier>(
      builder: (context, data, child) {
        if (data.tvSeriesState == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.tvSeriesState == RequestState.Error) {
          return Text(data.message);
        } else if (data.tvSeriesState == RequestState.Loaded) {
          int itemcount = data.tvSeriesDetail.seasons.length;
          return Container(
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
                      borderRadius: BorderRadius.all(
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
                              style: TextStyle(color: kRichBlack),
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
