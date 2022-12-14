import 'package:core/utils/failure.dart';
import 'package:tvseries/tvseries.dart';
import 'package:dartz/dartz.dart';

class GetNoowPlay {
  final TvRepository repository;

  GetNoowPlay(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNoowPlay();
  }
}
