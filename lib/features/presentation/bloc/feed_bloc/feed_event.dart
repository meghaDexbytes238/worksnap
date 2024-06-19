import 'package:equatable/equatable.dart';

import '../../../../imports.dart';

abstract class FeedEvent extends Equatable{
  const FeedEvent();

  @override
  List<Object> get props=>[];

}

class FetchFeedDataEvent extends FeedEvent{
  final BuildContext mContext;

  const FetchFeedDataEvent({required this.mContext});
}
class FetchFeedDataOnLoadEvent extends FeedEvent{
  final BuildContext mContext;
  const FetchFeedDataOnLoadEvent({required this.mContext});
}

class UpdateLikeCount extends FeedEvent{

  final bool liked;
  final int index;
  const UpdateLikeCount({ required this.liked,
    required this.index,});
}