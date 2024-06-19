import 'package:workplace/imports.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({Key? key, this.email = "example@gmail.com"})
      : super(key: key);
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController inputController = TextEditingController();
  Map<String, FocusNode> focusNodes = {
    'otp': FocusNode(),
  };
  String verificationCodeStr = "";

  int otpLength = 4;
  OverlayEntry? overlayEntry;
  String errorMessage = '';
  bool isHeight = true;

  @override
  void initState() {
    // TODO: implement initState
    focusNodes['otp']!.addListener(() {
      if (Platform.isIOS) {
        bool hasFocus = focusNodes['otp']!.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      }
    });
    // projectUtil.statusBarColor(
    //     statusBarColor: AppColors.appStatusBarColor,
    //     isNavigationBarDarkBrightness: true,
    //     isAppStatusDarkBrightness: true);
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    Widget resendCode = Container(
      margin: const EdgeInsets.only(bottom: 0, top: 0),
      child: AlreadyHaveAccountRow(
        leftText: "Resend code in",
        leftTextStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500),
        rightTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        rightText: " 00:48",
        isSubtitleTextVisible: false,
        isRightTextVisible: true,
        subtitleTextCallBack: () {
          // print("Hello");
          // inputController.clear();
        },
      ),
    );

    verificationCode() {
      Color fieldBackgroundColor = AppColors.textFiledColor.withOpacity(0.1);
      Color activeBorderColor = const Color(0xff5F9DFB);
      Color activeBackgroundColor = AppColors.textFiledColor.withOpacity(0.1);
      Color borderColor = AppColors.textFiledColor.withOpacity(0.1);
      Color disableBackgroundColor = AppColors.textFiledColor.withOpacity(0.1);

      return Container(
          // color: Colors.red,
          margin: const EdgeInsets.only(bottom: 0, top: 0),
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
          child: PinCodeFields(
            controller: inputController,
            length: otpLength,
            margin: const EdgeInsets.only(left: 3, right: 3),
            fieldBorderStyle: FieldBorderStyle.Square,
            responsive: false,
            fieldHeight: 52.0,
            focusNode: focusNodes['otp'],
            fieldWidth: 52.0,
            disableBackgroundColor: disableBackgroundColor,
            borderWidth: 1.0,
            padding: const EdgeInsets.only(top: 1),
            activeBorderColor: activeBorderColor,
            activeBackgroundColor: activeBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
            keyboardType: TextInputType.number,
            autoHideKeyboard: true,
            autofocus: false,
            fieldBackgroundColor: fieldBackgroundColor,
            borderColor: borderColor,
            textStyle: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            onChange: (value) {
              verificationCodeStr = value;
              // print("$value### $verificationCodeStr");
            },
            onComplete: (output) {
              //setState(() {
              verificationCodeStr = output;
              if (verificationCodeStr != "" &&
                  verificationCodeStr.length == otpLength) {
                setState(() {
                  errorMessage = '';
                });
                FocusScope.of(context).requestFocus(FocusNode());
              }
              // });
              // Your logic with pin code
              //print("${output}Final $verificationCodeStr");
            },
          ));
    }

    Widget otpErrorMsg = (errorMessage != '')
        ? Container(
            alignment: Alignment.center,
            height: 16,
            child: Text(
              errorMessage,
              style: appStyles.errorStyle(),
            ))
        : Container(
            height: 5,
          );

    Widget topText() {
      return Container(
        margin: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verify Code",
              textAlign: TextAlign.center,
              style: appStyles.onBoardingTitleStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                texColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Please enter the code we just sent to email ${widget.email}",
              textAlign: TextAlign.start,
              style: appStyles.onBoardingTitleStyle(
                fontSize: 16,
                height: 1.3,
                fontWeight: FontWeight.w400,
                texColor: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    // continue button
    continueButton() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: AppButton(
          buttonName: AppString.trans(context, AppString.continueBt),
          backCallback: () {
            if (verificationCodeStr != '' &&
                verificationCodeStr.trim().length == otpLength) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                errorMessage = '';
              });

              Navigator.push(
                  context,
                  SlideRightRoute(
                    widget: const NewPasswordScreen(),
                  ));
            } else {
              setState(() {
                if (verificationCodeStr == '') {
                  errorMessage =
                      AppString.trans(context, AppString.pleaseEnterOtp);
                } else {
                  errorMessage =
                      AppString.trans(context, AppString.pleaseEnterCorrectOtp);
                }
              });
            }
          },
        ),
      );
    }

    return ContainerFirst(
      reverse: false,
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      isFixedDeviceHeight: true,
      appBarHeight: 50,
      appBar: const CommonAppBar(
        title: "",
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          topText(),
          const SizedBox(height: 30),
          verificationCode(),
          otpErrorMsg,
          resendCode,
          const SizedBox(
            height: 10,
          ),
          continueButton(),
        ],
      ),
    );
  }

  //for ios done button callback
  onPressCallback() {
    removeOverlay();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //for keyboard done button
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView(
            onPressCallback: onPressCallback,
            buttonName: "Done",
          ));
    });

    overlayState.insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }
}
