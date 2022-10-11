import 'package:core/core.dart';
import 'package:watchlist/data/datasource/watchlist_local_data_source.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;
  WatchlistRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, String>> saveWatchlist(Watchlist watchlist) async {
    try {
      final result = await localDataSource
          .insertWatchlist(WatchlistTable.fromEntity(watchlist));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(Watchlist watchlist) async {
    try {
      final result = await localDataSource
          .removeWatchlist(WatchlistTable.fromEntity(watchlist));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getWatchlistById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Watchlist>>> getWatchlist() async {
    final result = await localDataSource.getWatchlist();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
