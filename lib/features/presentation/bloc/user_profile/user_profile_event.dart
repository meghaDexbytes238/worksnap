part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileDetails extends UserProfileEvent {
  final BuildContext mContext;
  const FetchProfileDetails ({required this.mContext});
}
class UserIsBlockedEvent extends UserProfileEvent {
  final BuildContext mContext;
  const UserIsBlockedEvent({required this.mContext});
}
class DeleteUserEvent extends UserProfileEvent {
  final BuildContext mContext;
  const DeleteUserEvent({required this.mContext});
}

class CancelEvent extends UserProfileEvent {
  final BuildContext mContext;
  const CancelEvent({required this.mContext});
}

class UpdateNotificationEvent extends UserProfileEvent {
  final bool? notifications;
  final BuildContext mContext;
  const UpdateNotificationEvent({this.notifications,required this.mContext});
}

class ChangePasswordEvent extends UserProfileEvent{
  String oldPassword;
  String newPassword;
  String confirmPassword;
  final BuildContext mContext;
  ChangePasswordEvent({required this.oldPassword,required this.newPassword,required this.confirmPassword,required this.mContext});
}

class UploadMediaEvent extends UserProfileEvent{
   String imagePath;
   final BuildContext mContext;
  UploadMediaEvent({required this.imagePath,required this.mContext});
}

class StoreMediaEvent extends UserProfileEvent{
String fileName;
final BuildContext mContext;
StoreMediaEvent({required this.fileName,required this.mContext});
}



