part of 'team_member_bloc.dart';

abstract class TeamMemberState extends Equatable {
  const TeamMemberState();

  @override
  List<Object> get props => [];
}

class TeamMemberInitial extends TeamMemberState {}

class TeamMemberLoadingState extends TeamMemberState {}

class TeamMemberDataFetched extends TeamMemberState {}
