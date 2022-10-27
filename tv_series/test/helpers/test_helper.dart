import 'package:core/utils/ssl_pinning.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

@GenerateMocks([
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
], customMocks: [
  MockSpec<IOClientWithSSL>(as: #MockHttpClient)
])
void main() {}
