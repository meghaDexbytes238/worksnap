abstract class BirthdayState {
  BirthdayState ();
  List<Object> get props => [];
}

class BirthdayInitialState extends BirthdayState {}
class BirthdayLoadingState extends BirthdayState {}

class FetchedBirthdayDataState extends BirthdayState {}
