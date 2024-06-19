import '../../../../imports.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class FetchEventsData extends EventsEvent {
  final BuildContext mContext;
  FetchEventsData ({required this.mContext});
}