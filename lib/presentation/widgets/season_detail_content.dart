import 'package:ditonton/domain/entities/tv/tv_series_season_detail.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/tv/tv_series_episode_detail_page.dart';
import 'package:flutter/material.dart';

class SeasonDetailContent extends StatelessWidget {
  final TVSeriesSeasonDetail? seasonDetail;

  SeasonDetailContent(
    this.seasonDetail,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(seasonDetail!.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (seasonDetail!.overview != '') ...[
                Text(
                  'Overview',
                  style: kHeading6,
                ),
                Text(seasonDetail!.overview),
              ],
              SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Release Date: '),
                  Text(seasonDetail!.airDate),
                ],
              ),
              SizedBox(height: 16.0),
              ...seasonDetail!.episodes
                  .map(
                    (episode) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          'Episode ${episode.episodeNumber}',
                          style: TextStyle(color: kRichBlack),
                        ),
                        tileColor: kMikadoYellow,
                        subtitle: Text(
                          episode.name.toString(),
                          style: TextStyle(color: kRichBlack),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            TVSeriesEpisodeDetailPage.ROUTE_NAME,
                            arguments: episode,
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
