import '../../../../core/util/app_navigator/app_navigator.dart';
import '../../../../imports.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  GetFeedData feedDetails =
      GetFeedData(RepositoryImpl(WorkplaceDataSourcesImpl()));

  List<FeedData> feedPostList = [];
  FeedData? feedData;
  String url="";

  FeedBloc() : super(FeedInitialState()) {
    on<FetchFeedDataEvent>((event, emit) async {
      emit(FeedLoadingState());
      Either<Failure,FeedDataModel> response= await feedDetails.call(FeedParams(url : null));
      response.fold((left) {
        if(left is UnauthorizedFailure)
        {
          appNavigator.tokenExpireUserLogout(event.mContext);
        }
      },
              (right) {
                feedPostList =right.data??[];
                emit(FeedDataState());
      });
    });

    on<FetchFeedDataOnLoadEvent>((event, emit) async {
      //emit(FeedLoadingState());
      fetchFeedData(event.mContext);
    });

    on<UpdateLikeCount>((event, emit) async {
      emit(FeedLoadingState());
      feedPostList[event.index].isLike = event.liked;
      event.liked ?
      feedPostList[event.index].likes = (feedPostList[event.index].likes)! + 1:
      feedPostList[event.index].likes = (feedPostList[event.index].likes)! - 1;
      emit(UpdateLikeCountState());
    });
  }

  Future<void> fetchFeedData(BuildContext context) async {
    feedDetails.call(FeedParams(url : (url.isEmpty)?null: url)).fold((left) {
      if (left is UnauthorizedFailure) {
        appNavigator.tokenExpireUserLogout(context);
      }
    }, (right) {
      if(url.isNotEmpty)
        {
          feedPostList.addAll(right.data ?? []);
        }
      else
        {
          feedPostList = right.data ?? [];
         }
       url = right.pagination!.nextPageApiUrl! ?? "";
    });

  }
}
