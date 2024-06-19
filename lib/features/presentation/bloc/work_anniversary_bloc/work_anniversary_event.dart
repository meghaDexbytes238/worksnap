import '../../../../imports.dart';

abstract class WorkAnniversaryEvent extends Equatable {
  WorkAnniversaryEvent();

  @override
  List<Object> get props => [];
}

class FetchWorkAnniversaryDataEvent extends WorkAnniversaryEvent {
  final BuildContext mContext;
  FetchWorkAnniversaryDataEvent({required this.mContext});
}