abstract class FeedState {
  FeedState();
  List<Object> get props=>[];

}

class FeedInitialState extends FeedState{}
class FeedLoadingState extends FeedState{}
class FeedDataState extends FeedState{}

class UpdateLikeCountState extends FeedState{}