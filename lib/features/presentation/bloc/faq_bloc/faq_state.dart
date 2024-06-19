import 'package:workplace/core/util/app_navigator/app_navigator.dart';
import 'package:workplace/imports.dart';
import 'package:workplace/features/presentation/widgets/alerts/error_alert.dart';

abstract class FaqState {
  FaqDataModel? faqDataModel;
  FaqState({this.faqDataModel});
  void updateModel({faqDataModel}) {
    this.faqDataModel = faqDataModel;
  }

  get getFaqModel => faqDataModel;
}

class FaqInitState extends FaqState {}
class FaqLoadingState extends FaqState {}
class FetchFaqDataState extends FaqState {}



class FaqInProgressState extends FaqState {
  Map? requestData;
  FaqInProgressState({this.requestData});
}

// class FaqLoadingState extends FaqState{}

class FaqErrorState extends FaqState {
  FaqErrorState(
      {required BuildContext context,
        String? errorMessage,
        String? phone,
        int? code,
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
        });
  }
}

class GetFaqDataDoneState extends FaqState {
  FaqDataModel? responseData;
  GetFaqDataDoneState({this.responseData}) : super();
  @override
  String toString() => ' }';
}
