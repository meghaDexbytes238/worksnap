import 'package:workplace/imports.dart';

class PostUploadMedia
    implements UseCase<UploadMediaModel, UploadMediaParams> {
  final Repository repository;

  PostUploadMedia(this.repository);

  @override
  Future<Either<Failure, UploadMediaModel>> call(
      UploadMediaParams params) async {
    try {
      return repository.postUploadMedia(params: params);

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

class UploadMediaParams extends Equatable {
  String filePath;
  String collectionName;

  UploadMediaParams({
    required this.filePath,
    this.collectionName = 'profile_photo'
  });

  @override
  List<Object> get props => [filePath];
}
