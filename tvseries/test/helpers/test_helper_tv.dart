import 'package:core/data/datasources/db/database_helper.dart';
import 'package:http/io_client.dart';
import 'package:tvseries/data/datasources/tv_local_data_source.dart';
import 'package:tvseries/data/datasources/tv_remote_data_source.dart';
import 'package:tvseries/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteData,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
