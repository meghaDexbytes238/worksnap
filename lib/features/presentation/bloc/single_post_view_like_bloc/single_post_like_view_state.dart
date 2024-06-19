abstract class SinglePostViewLikeState {
  SinglePostViewLikeState();
  List<Object> get props => [];
}

class SinglePostViewLikeInitialState extends SinglePostViewLikeState{}

class SinglePostViewLikeLoadingState extends SinglePostViewLikeState{}

class FetchedSinglePostViewLikeTypeState extends SinglePostViewLikeState{}

class FetchedSinglePostViewLikeAppliedDataState extends SinglePostViewLikeState{}

class PostLikeDoneState extends SinglePostViewLikeState{
  final int index;
  final bool liked;
  PostLikeDoneState({required this.index, required this.liked});
}

class SinglePostViewLikeUpdateDoneState extends SinglePostViewLikeState{}

class SinglePostViewLikeErrorState extends SinglePostViewLikeState{}

class FetchedSinglePostDataState extends SinglePostViewLikeState{}