import 'package:core/domain/usecases/watchlist/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = SaveWatchlist(mockWatchlistRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockWatchlistRepository.saveWatchlist(testWatchlist))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testWatchlist);
    // assert
    verify(mockWatchlistRepository.saveWatchlist(testWatchlist));
    expect(result, const Right('Added to Watchlist'));
  });
}
