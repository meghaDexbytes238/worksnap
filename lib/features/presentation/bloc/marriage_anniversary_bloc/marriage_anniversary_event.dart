
import '../../../../imports.dart';

abstract class MarriageAnniversaryEvent extends Equatable {
  const MarriageAnniversaryEvent();

  @override
  List<Object> get props => [];
}

class FetchMarriageAnniversaryDataEvent extends MarriageAnniversaryEvent {
  final BuildContext mContext;
  FetchMarriageAnniversaryDataEvent({required this.mContext});
}