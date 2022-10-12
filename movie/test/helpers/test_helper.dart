import 'package:core/utils/ssl_pinning.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
], customMocks: [
  MockSpec<IOClientWithSSL>(as: #MockHttpClient)
])
void main() {}
