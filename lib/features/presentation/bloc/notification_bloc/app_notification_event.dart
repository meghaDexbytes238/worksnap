import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AppNotificationEvent extends Equatable {
  const AppNotificationEvent();
  @override
  List<Object> get props => [];
}

class GetAppNotificationListEvent extends AppNotificationEvent {
  final BuildContext? mContext;
  GetAppNotificationListEvent({this.mContext});
  @override
  String toString() => 'RemoveProduct { index:}';
}

class MarkNotificationDisplayedEvent extends AppNotificationEvent{
  final BuildContext? mContext;
  const MarkNotificationDisplayedEvent({ this.mContext});
}

class MarkNotificationReadEvent extends AppNotificationEvent{
  final BuildContext? mContext;
  int? messageID;
  int? postId;
  int? leaveId;
  String? postType;
  MarkNotificationReadEvent({ this.mContext,this.messageID,this.postType,this.postId,this.leaveId});
}
class MarkNotificationRedirectReadDisplayEvent extends AppNotificationEvent{
  final BuildContext? mContext;
  final int? msgId;
 const MarkNotificationRedirectReadDisplayEvent({ this.mContext,this.msgId});
}