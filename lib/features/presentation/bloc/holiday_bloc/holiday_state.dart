abstract class HolidayState {
  HolidayState ();

  List<Object> get props => [];
}

class HolidayInitialState extends HolidayState {}
class HolidayLoadingState extends HolidayState {}
class HolidayDataState extends HolidayState {}
