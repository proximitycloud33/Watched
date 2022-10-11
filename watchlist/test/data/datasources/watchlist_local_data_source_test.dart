import 'package:watchlist/data/datasource/watchlist_local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late WatchlistLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        WatchlistLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testWatchlistTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testWatchlistTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testWatchlistTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testWatchlistTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testWatchlistTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testWatchlistTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testWatchlistTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testWatchlistTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Watchlist By Id', () {
    const tId = 1;

    test('should return Watchlist Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(tId))
          .thenAnswer((_) async => testWatchlistMap);
      // act
      final result = await dataSource.getWatchlistById(tId);
      // assert
      expect(result, testWatchlistTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getWatchlistById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist())
          .thenAnswer((_) async => [testWatchlistMap]);
      // act
      final result = await dataSource.getWatchlist();
      // assert
      expect(result, [testWatchlistTable]);
    });
  });
}
