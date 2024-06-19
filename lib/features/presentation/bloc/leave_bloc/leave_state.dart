abstract class LeaveState {
  LeaveState();
  List<Object> get props => [];
}

class LeaveInitialState extends LeaveState{}

class LeaveLoadingState extends LeaveState{}
class LeaveUpdateLoadingState extends LeaveState{}

class FetchedLeaveTypeState extends LeaveState{}

class FetchedTeamLeaveAppliedDataState extends LeaveState{}
class FetchedLeaveAppliedDataOnRefreshState extends LeaveState{}

class LeaveAppliedState extends LeaveState{}

class LeaveCancelState extends LeaveState{}

class LeaveErrorState extends LeaveState{}

class FetchedLeaveDetailByIdState extends LeaveState{}
class FetchedTeamLeaveDetailByIdState extends LeaveState{}

class LeaveRequestState extends LeaveState{}