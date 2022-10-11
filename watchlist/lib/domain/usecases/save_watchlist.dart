import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Watchlist watchlist) {
    return repository.saveWatchlist(watchlist);
  }
}
