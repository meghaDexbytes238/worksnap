import '../../../../imports.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchHomeData extends HomeEvent {
  final BuildContext mContext;
  FetchHomeData({required this.mContext});
}