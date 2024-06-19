import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LeaveEvent extends Equatable{
  const LeaveEvent();

  @override
  List<Object> get props => [];
}

class FetchLeaveTypeEvent extends LeaveEvent{
  final BuildContext? mContext;
  const FetchLeaveTypeEvent({required this.mContext,});
}

class SubmitLeaveRequestEvent extends LeaveEvent{
  final BuildContext? mContext;
  final int leaveTypeID;
  final String reason;
  final String duration;
  final String startDate;
  final String endDate;
  const SubmitLeaveRequestEvent(
      {
        required this.mContext,
        required this.leaveTypeID,
        required this.reason,
        required this.duration,
        required this.startDate,
        required this.endDate,
      });
}

class GetLeaveDataEvent extends LeaveEvent{
  final BuildContext? mContext;
  const GetLeaveDataEvent({required this.mContext});
}

class GetLeaveDataOnRefresh extends LeaveEvent{
  final BuildContext? mContext;
  const GetLeaveDataOnRefresh({this.mContext});
}

class SubmitCancelLeaveRequestEvent extends LeaveEvent{
  final BuildContext? mContext;
  final int id;
  final String status;
  const SubmitCancelLeaveRequestEvent(
      {
        required this.mContext,
        required this.id,
        required this.status,
      });
}

class FetchLeaveDetailByIdEvent extends LeaveEvent{
  final BuildContext? mContext;
  final int postId;
  const FetchLeaveDetailByIdEvent({
    required this.mContext,
    required this.postId,
  });
}

class LeaveRequestEvent extends LeaveEvent{
  final BuildContext? mContext;
  final int id;
  final String status;
  const LeaveRequestEvent(
      {
        required this.mContext,
        required this.id,
        required this.status,
      });
}

class FetchTeamLeaveDetailByIdEvent extends LeaveEvent{
  final BuildContext? mContext;
  final int postId;
  const FetchTeamLeaveDetailByIdEvent({
    required this.mContext,
    required this.postId,
  });
}

class FetchTeamLeaveAppliedDataEvent extends LeaveEvent {
  final BuildContext? mContext;
  const FetchTeamLeaveAppliedDataEvent({required this.mContext});
}