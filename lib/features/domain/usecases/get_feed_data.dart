import 'package:either_dart/src/either.dart';
import 'package:equatable/equatable.dart';
import 'package:workplace/core/error/failures.dart';
import 'package:workplace/features/domain/domain.dart';
import '../../data/models/get_feed_data_model.dart';

class GetFeedData implements UseCase<FeedDataModel,FeedParams>{
  final Repository repository;

  GetFeedData(this.repository);

  @override
  Future<Either<Failure, FeedDataModel>> call(FeedParams params)async {
    try {
      return repository.getFeedData(feedParams : params);
    } catch (e) {
      if(e is UnauthorizedFailure)
      {
        return Left(UnauthorizedFailure());
      }
      if (e is ServerFailure) {
        return Left(ServerFailure());
      }
      if (e is NetworkFailure) {
        return Left(NetworkFailure());
      }
      return Left(ServerFailure());
    }
  }
}

class FeedParams extends Equatable{
  String? url;
  FeedParams({this.url});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}