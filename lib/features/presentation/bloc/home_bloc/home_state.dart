import 'package:workplace/core/util/app_navigator/app_navigator.dart';
import 'package:workplace/imports.dart';
import 'package:workplace/features/presentation/widgets/alerts/error_alert.dart';

abstract class HomeState {
  HomeState ();
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeErrorState extends HomeState {}
class FetchedHomeDataState extends HomeState {}
