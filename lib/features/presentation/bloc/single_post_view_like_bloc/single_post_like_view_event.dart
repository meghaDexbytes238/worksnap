import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SinglePostViewLikeEvent extends Equatable{
  const SinglePostViewLikeEvent();

  @override
  List<Object> get props => [];
}


class SubmitLikeRequestEvent extends SinglePostViewLikeEvent{
  final BuildContext? mContext;
  final int postId;
  final int index;
  final bool liked;
  const SubmitLikeRequestEvent(
      {
        required this.mContext,
        required this.postId,
        required this.index,
        required this.liked,
      });
}

class SubmitCancelSinglePostViewLikeRequestEvent extends SinglePostViewLikeEvent{
  final BuildContext? mContext;
  final int id;
  const SubmitCancelSinglePostViewLikeRequestEvent(
      {
        required this.mContext,
        required this.id,
      });
}

class FetchSinglePostEvent extends SinglePostViewLikeEvent
{
  final BuildContext? mContext;
  final int postId;
  const FetchSinglePostEvent({
    required this.mContext,
    required this.postId,
  });
}
