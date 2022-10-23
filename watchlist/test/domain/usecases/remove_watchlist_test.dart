import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist_domain.dart';

import '../../dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = RemoveWatchlist(mockWatchlistRepository);
  });

  test('should remove watchlist from repository', () async {
    // arrange
    when(mockWatchlistRepository.removeWatchlist(testWatchlist))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testWatchlist);
    // assert
    verify(mockWatchlistRepository.removeWatchlist(testWatchlist));
    expect(result, const Right('Removed from watchlist'));
  });
}
