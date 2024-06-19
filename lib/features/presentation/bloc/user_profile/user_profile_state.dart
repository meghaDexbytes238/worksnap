part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileFetching extends UserProfileState {
 BuildContext? mcontext;
  UserProfileFetching({required this.mcontext});
}


class UserProfileFetched extends UserProfileState {
  String? displayMessage;
  UserProfileFetched({ this.displayMessage});
}


class DeleteUserState extends UserProfileState{}

class DeleteUserErrorState extends UserProfileState{
  String errorMessage;
  DeleteUserErrorState({required this.errorMessage});
}

class CancelState extends UserProfileState{}

class UpdateNotificationState extends UserProfileState{

}

class UpdateNotificationErrorState extends UserProfileState{
  String? errorMessage;
  UpdateNotificationErrorState({required this.errorMessage});
}


class ChangePasswordState extends UserProfileState{}


class ChangePasswordErrorState extends UserProfileState{
  String? errorMessage;
  ChangePasswordErrorState({required this.errorMessage});
}

class UploadMediaState extends UserProfileState{}

class UploadMediaErrorState extends UserProfileState{
  String? errorMessage;
  UploadMediaErrorState({required this.errorMessage});
}


class StoreMediaState extends UserProfileState{

}