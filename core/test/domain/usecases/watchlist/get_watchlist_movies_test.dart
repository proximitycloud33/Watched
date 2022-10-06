import 'package:core/domain/usecases/watchlist/get_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlist(mockWatchlistRepository);
  });

  test('should get list of watchlist from the repository', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlist())
        .thenAnswer((_) async => Right(testListofWatchlist));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testListofWatchlist));
  });
}
