abstract class WorkAnniversaryState {
  WorkAnniversaryState ();
  @override
  List<Object> get props => [];
}

class WorkAnniversaryInitialState extends WorkAnniversaryState {}
class WorkAnniversaryLoadingState extends WorkAnniversaryState {}

class FetchedWorkAnniversaryDataState extends WorkAnniversaryState {}
