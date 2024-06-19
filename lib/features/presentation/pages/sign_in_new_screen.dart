import 'package:platform_detector/enums.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:workplace/imports.dart';
import 'package:workplace/responsive.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Map<String, TextEditingController> controllers = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  Map<String, FocusNode> focusNodes = {
    'email': FocusNode(),
    'password': FocusNode(),
  };

  Map<String, String> errorMessages = {
    'email': "",
    'password': "",
  };

  String countryCode = '';
  OverlayEntry? overlayEntry;
  Color? statusBarColor;
  String phoneNumber = '';
  bool hideNewPassword = true;
  final PlatformType currentPlatformType = PlatformDetector.platform.type;
  void togglePasswordVisibility1() =>
      setState(() => hideNewPassword = !hideNewPassword);

  @override
  void initState() {
    // TODO: implement initState

      focusNodes['email']!.addListener(() {
        if (Platform.isIOS) {
          bool hasFocus = focusNodes['email']!.hasFocus;
          if (hasFocus) {
            showOverlay(context);
          } else {
            removeOverlay();
          }
        }
      });

    // FirebaseMessaging.instance.requestPermission().then((value) async {
    //   await FirebaseMessaging.instance.getToken().then((value) {
    //     if (value != null) {
    //       PrefUtils().saveStr(WorkplaceNotificationConst.deviceTokenC, value);
    //     }
    //   });
    // });
    // projectUtil.deviceInfo();
    super.initState();
  }

  @override
  void dispose() {
    controllers['p'
            'hone']
        ?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    SignInBloc signInBloc = BlocProvider.of<SignInBloc>(context);

    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    checkEmail(value, fieldEmail, {onchange = false}) {
      if (Validation.isNotEmpty(value.trim())) {
        setState(() {
          if (Validation.validateEmail(value.trim())){
            errorMessages[fieldEmail] = "";
          } else {
            if (!onchange) {
              errorMessages[fieldEmail] = AppString.trans(context, AppString.emailHintError1);
            }
          }
        });
      } else {
        setState(() {
          if (!onchange) {
            if (fieldEmail == 'email') {
              errorMessages[fieldEmail] =
                  AppString.trans(context, AppString.emailHintError);
            }
          }
        });
      }
    }

    //Check password field
    checkPassword(value, fieldEmail, {onchange = false}) {
      if (Validation.isNotEmpty(value.trim())) {
        setState(() {
          if (Validation.passwordLength(value.trim())) {
            if (!onchange) {
              errorMessages[fieldEmail] = "";

              // AppString.trans(
              // context, AppString.invalidPassword);
            }
          } else {
            if (!onchange) {
              errorMessages[fieldEmail] = "";

              // AppString.trans(
              // context, AppString.invalidPassword);
            }
          }
        });
      } else {
        setState(() {
          if (!onchange) {
            if (fieldEmail == 'password') {
              errorMessages[fieldEmail] =
                  AppString.trans(context, AppString.pleaseEnterPassword);
            } else if (fieldEmail == 'last_name') {
              errorMessages[fieldEmail] =
                  AppString.trans(context, AppString.enterLastName);
            }
          }
        });
      }
    }

    bool validateFields({isButtonClicked = false}) {
      if (controllers['email']!.text.isEmpty || controllers['email']!.text == '') {
        setState(() {
          if (isButtonClicked) {
            errorMessages['email'] =
                AppString.trans(context, AppString.emailHintError);
          }
        });
        return false;
      } else if (!Validation.validateEmail(controllers['email']!.text)) {
        setState(() {
          if (isButtonClicked) {
            errorMessages['email'] =
                AppString.trans(context, AppString.emailHintError1);
          }
        });
        return false;
      } else if (controllers['password']?.text == null ||
          controllers['password']?.text == '') {
        setState(() {
          if (isButtonClicked) {
            errorMessages['password'] =
                AppString.trans(context, AppString.pleaseEnterPassword);
          }
        });
        return false;
      } else {
        return true;
      }
    }

    emailField() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
        width: Responsive.isMobile(context)?MediaQuery.of(context).size.width : MediaQuery.of(context).size.width/3.5,
        child: CommonTextFieldWithError(
          focusNode: focusNodes['email'],
          isShowBottomErrorMsg: true,
          errorMessages: errorMessages['email']?.toString() ?? '',
          controllerT: controllers['email'],
          borderRadius: 8,
          inputHeight: 50,
          errorLeftRightMargin: 0,
          maxCharLength: 50,
          errorMsgHeight: 24,
          autoFocus: false,
          showError: true,
          capitalization: CapitalizationText.none,
          cursorColor: Colors.grey,
          placeHolderTextWidget: Padding(
            padding: const EdgeInsets.only(left: 6.0, bottom: 3),
            child: Text("Work Email",
                textAlign: TextAlign.start,
                style: appStyles.texFieldPlaceHolderStyle()),
          ),
          enabledBorderColor: AppColors.textFiledBorderColor,
          focusedBorderColor: AppColors.textFiledBorderColor,
          backgroundColor: AppColors.white,
          textInputAction: TextInputAction.next,
          borderStyle: BorderStyle.solid,
          inputKeyboardType: InputKeyboardTypeWithError.email,
          hintText: "name@company.com",
          hintStyle: appStyles.hintTextStyle(),
          textStyle: appStyles.textFieldTextStyle(),
          inputFieldSuffixIcon: Padding(
            padding: const EdgeInsets.only(right: 18, left: 10),
            child: WorkplaceIcons.iconImage(
                imageUrl: WorkplaceIcons.emailIcon,
                imageColor: controllers['email']!.text.isEmpty
                    ? const Color(0xFF575757)
                    : AppColors.buttonBgColor4),
          ),
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          onTextChange: (value) {
            checkEmail(value, 'email', onchange: true);
          },
          onEndEditing: (value) {
            checkEmail(value, 'email');
            FocusScope.of(context).requestFocus(focusNodes['password']);
          },
        ),
      );
    }

    Widget visibilityOffIcon = Icon(
      Icons.visibility_off,
      color: controllers['password']!.text.isEmpty
          ? const Color(0xFF575757)
          : AppColors.buttonBgColor4,
      size: 23,
    );

    Widget visibilityOnIcon = Icon(
      Icons.visibility,
      color: controllers['password']!.text.isEmpty
          ? const Color(0xFF575757)
          : AppColors.buttonBgColor4,
      size: 23,
    );

    //Password Field
    passwordField() {
      return Container(
        width: Responsive.isMobile(context)?MediaQuery.of(context).size.width : MediaQuery.of(context).size.width/3.5,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        // width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTextFieldWithError(
              focusNode: focusNodes['password'],
              isShowBottomErrorMsg: true,
              errorMessages: errorMessages['password']?.toString() ?? '',
              controllerT: controllers['password'],
              borderRadius: 8,
              inputHeight: 50,
              errorMsgHeight: 16,
              autoFocus: false,
              errorLeftRightMargin: 0,
              maxCharLength: 16,
              capitalization: CapitalizationText.none,
              cursorColor: Colors.grey,
              placeHolderTextWidget: Padding(
                padding: const EdgeInsets.only(left: 6.0, bottom: 3),
                child: Text("Password",
                    textAlign: TextAlign.start,
                    style: appStyles.texFieldPlaceHolderStyle()),
              ),
              enabledBorderColor: AppColors.textFiledBorderColor,
              focusedBorderColor: AppColors.textFiledBorderColor,
              backgroundColor: AppColors.white,
              textInputAction: TextInputAction.done,
              borderStyle: BorderStyle.solid,
              inputKeyboardType: InputKeyboardTypeWithError.email,
              obscureText: hideNewPassword,
              hintText: AppString.trans(context, AppString.password),
              errorStyle: appStyles.errorStyle(fontSize: 10),
              errorMessageStyle: appStyles.errorStyle(fontSize: 10),
              hintStyle: appStyles.hintTextStyle(),
              textStyle: appStyles.textFieldTextStyle(),
              contentPadding: const EdgeInsets.only(left: 15, right: 15),
              inputFieldSuffixIcon: controllers['password']!.text.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: WorkplaceIcons.iconImage(
                          iconSize: const Size(16, 16),
                          imageUrl: WorkplaceIcons.passwordIcon,
                          imageColor: const Color(0xFF575757)),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        right: 2,
                      ),
                      child: IconButton(
                        icon: hideNewPassword
                            ? visibilityOffIcon
                            : visibilityOnIcon,
                        onPressed: togglePasswordVisibility1,
                      ),
                    ),
              onTextChange: (value) {
                checkPassword(value, 'password', onchange: false);
              },
              onEndEditing: (value) {
                checkPassword(value, 'password');
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ],
        ),
      );
    }

    // login button
    loginButton() {
      return Container(
        width: Responsive.isMobile(context)?MediaQuery.of(context).size.width : MediaQuery.of(context).size.width/3.5,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: AppButton(
          buttonName: AppString.trans(context, AppString.loginT),
          backCallback: () {
            String email = controllers['email']!.text.trim();
            String password = controllers['password']!.text.trim();
            if (validateFields(isButtonClicked: true)) {
              Map data = {"email": email, "password": password};
              signInBloc
                  .add(SubmitSignInEvent(requestData: data, mContext: context));
            }
          },
        ),
      );
    }

    Widget topIcon() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WorkplaceIcons.iconImage(
              // iconSize: const Size(100,110),
              iconSize: const Size(10, 45),
              imageUrl: WorkplaceIcons.dexBytesIcon,
              imageColor: AppColors.buttonBgColor4),
        ],
      );
    }

    Widget forgotPasswordText() {
      return Padding(
        padding: const EdgeInsets.only(right: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(widget: const ForgotPasswordScreen()),
                  );
                },
                child: const Text("Forgot Password?",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.buttonBgColor4,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline)),
              ),
            ),
          ],
        ),
      );
    }

    return ContainerFirst(
        reverse: false,
        contextCurrentView: context,
        isSingleChildScrollViewNeed: true,
        isFixedDeviceHeight: true,
        appBarHeight: -1,
        appBar: Container(),

        containChild: BlocListener<SignInBloc, SignInState>(
          bloc: signInBloc,
          listener: (BuildContext context, SignInState state) {
            if (state is SignInDoneState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DashBoardPage()),
                  (route) => false);
            }
            if (state is SignInErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text((state.errorMessage != null)
                      ? '${state.errorMessage}'
                      : 'Check your login details'),
                  backgroundColor: Colors.red));
            }
          },
          child: BlocBuilder<SignInBloc, SignInState>(builder: (context, _) {
            return  Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                topIcon(),
                const SizedBox(height: 75),
                emailField(),
                const SizedBox(height: 8),
                passwordField(),
                // forgotPasswordText(),
                const SizedBox(
                  height: 25,
                ),
                loginButton(),
                // AlreadyHaveAccountRow(
                //   rightText:"Contact Us?",
                //   rightTextStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.buttonBgColor4,decoration: TextDecoration.underline),
                //   leftTextStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: AppColors.hintTextColor),
                //   leftText: "Need help?",),
              ],
            );
          }),
        ));

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
