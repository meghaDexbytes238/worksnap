import 'package:workplace/features/data/models/signin_model.dart';
import 'package:workplace/features/presentation/widgets/alerts/error_alert.dart';
import 'package:workplace/core/util/app_navigator/app_navigator.dart';
import 'package:workplace/imports.dart';

//For Driver
abstract class SignInState {
  SignInModel? signInModel; //for driver
  SignInState({this.signInModel});
  void updateModel({signInModel}) {
    this.signInModel = signInModel;
  } // For driver

  get getSignInModel => signInModel;
}

class SignInInitStat extends SignInState {}

class SignInInProgressState extends SignInState {
  Map? requestData;
  SignInInProgressState({this.requestData});
}

class SignInErrorState extends SignInState {
  String? errorMessage;
  String? phone;
  int? code;
  SignInErrorState(
      {required BuildContext context,
      this.code,
      this.errorMessage,
      this.phone,
      okCallBack}) {
    ErrorAlert(
        context: context,
        message: errorMessage,
        callBackYes: (mContext) {
          if (okCallBack != null) {
            okCallBack();
          } else {
            appNavigator.popBackStack(mContext);
          }
          // appNavigator.popBackStack(context);
          // appNavigator.launchVerificationCodePage(context, userEmail: emailId);
        });
  }
}

class SignInDoneState extends SignInState {
  SignInModel? signInModelOld; // for driver
  // SignInProviderModel? signInProviderModel;
  SignInDoneState({this.signInModelOld}) : super(signInModel: signInModelOld);
  @override
  String toString() => ' $signInModelOld }';
}

class VisibiltyToggle extends SignInState{}
