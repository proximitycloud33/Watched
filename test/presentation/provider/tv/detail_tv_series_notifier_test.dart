import 'package:ditonton/domain/usecases/tv/get_detail_tv_series.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist_status.dart';
import 'package:ditonton/presentation/provider/tv/detail_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'mocks/detail_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetDetailTVSeries, GetWatchListStatus])
void main() {
  late DetailTVSeriesNotifier provider;
  late MockGetDetailTVSeries mockGetDetailTVSeries;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetDetailTVSeries = MockGetDetailTVSeries();
      mockGetWatchListStatus = MockGetWatchListStatus();
    },
  );
}
