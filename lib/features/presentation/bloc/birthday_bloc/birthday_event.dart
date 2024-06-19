import '../../../../imports.dart';

abstract class BirthdayEvent extends Equatable {
  const BirthdayEvent();

  @override
  List<Object> get props => [];
}

class FetchBirthdayDataEvent extends BirthdayEvent {
  final BuildContext mContext;
  FetchBirthdayDataEvent({required this.mContext});
}