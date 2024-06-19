part of 'team_member_bloc.dart';

abstract class TeamMemberEvent extends Equatable {
  const TeamMemberEvent();

  @override
  List<Object> get props => [];
}

class FetchTeamList extends TeamMemberEvent {
  final BuildContext mContext;
  FetchTeamList({required this.mContext});
}
