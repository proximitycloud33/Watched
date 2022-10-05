import 'package:core/domain/entities/watchlist.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, String>> saveWatchlist(Watchlist watchlist);
  Future<Either<Failure, String>> removeWatchlist(Watchlist watchlist);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Watchlist>>> getWatchlist();
}
