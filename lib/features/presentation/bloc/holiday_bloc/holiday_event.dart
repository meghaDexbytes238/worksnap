import '../../../../imports.dart';

abstract class HolidayEvent extends Equatable {
  const HolidayEvent();

  @override
  List<Object> get props => [];
}

class FetchHolidayDataEvent extends HolidayEvent {
  final BuildContext mContext;
  FetchHolidayDataEvent({required this.mContext});
}