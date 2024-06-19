abstract class AboutState {
  AboutState ();
  @override
  List<Object> get props => [];
}

class AboutInitialState extends AboutState {}
class AboutLoadingState extends AboutState {}

class FetchedAboutDataState extends AboutState{}