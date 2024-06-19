import 'package:workplace/imports.dart';
import '../../../../core/util/app_navigator/app_navigator.dart';

class SinglePostViewLikeBloc extends Bloc<SinglePostViewLikeEvent, SinglePostViewLikeState> {

  PostLike postLike = PostLike(RepositoryImpl(WorkplaceDataSourcesImpl()));
  PostLeaveStatusChange leaveStatusDetails = PostLeaveStatusChange(RepositoryImpl(WorkplaceDataSourcesImpl()));
  GetSinglePost  singlePost = GetSinglePost(RepositoryImpl(WorkplaceDataSourcesImpl()));

  SinglePostData? singlePostData2;


  SinglePostViewLikeBloc() : super(SinglePostViewLikeInitialState()) {

    on<SubmitLikeRequestEvent>((event, emit) async {
      //LoadingWidget2.startLoadingWidget(event.mContext!);
      Either<Failure, dynamic> response =
          await postLike.call(PostLikeParams(
        postId: event.postId
      ));
      response.fold((left) {
        //LoadingWidget2.endLoadingWidget(event.mContext!);
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext!);
        }
      }, (right) {
       // LoadingWidget2.endLoadingWidget(event.mContext!);
        emit(PostLikeDoneState(index: event.index, liked: event.liked));
      });
    });
   on<FetchSinglePostEvent>((event,emit) async {
     //LoadingWidget2.startLoadingWidget(event.mContext!);
     emit(SinglePostViewLikeLoadingState());
     Either<Failure, dynamic> response =await singlePost.call(
         SinglePostParams( postId: event.postId)
     );
     response.fold((left) {
       if(left is UnauthorizedFailure)
       {
         appNavigator.tokenExpireUserLogout(event.mContext!);
       }
     }, (right) {
       singlePostData2 = right.data;
       emit(FetchedSinglePostDataState());
     }
     );
   });



  }
}
