// ignore_for_file: prefer_const_constructors
import 'package:permission_handler/permission_handler.dart';
import 'package:workplace/features/presentation/widgets/detail_screen_appbar.dart';
import 'package:workplace/features/presentation/widgets/settings_list_view.dart';
import 'package:workplace/imports.dart';

import '../../data/models/settings_data_model.dart';

class ProfileSettingsScreen extends StatefulWidget {
  bool? enableDelete;
  ProfileSettingsScreen({super.key, this.enableDelete});
  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  late UserProfileBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    bloc = BlocProvider.of<UserProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state is CancelState) {
          Navigator.of(context).pop();
        }

        if (state is UpdateNotificationState) {
          print('object...........................');
        }

        if (state is DeleteUserState) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SignInScreen()));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('User deleted successfully'),
            duration: Duration(seconds: 3),
          ));
        }
        if (state is DeleteUserErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            duration: const Duration(seconds: 3),
          ));
        }
      },
      builder: (context, state) {
        return PopScope(
            onPopInvoked: null, //_onBackPressed,
            child: ContainerFirst(
                contextCurrentView: context,
                isSingleChildScrollViewNeed: true,
                isFixedDeviceHeight: true,
                appBarHeight: 50,
                appBar: DetailsScreenAppBar(
                  title: 'Settings',
                ),
                containChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SettingsListView(
                      isHideIconVisible: true,
                      notification: bloc.notification,
                      onClickListCallBack: (title) {
                        redirectTo(title, context);
                      },
                      enableDelete: widget.enableDelete ?? false,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // version
                  ],
                )));
      },
    );
  }

  Future<void> redirectTo(title, context) async {
    if (title == "Change Password") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(widget: const ChangePasswordScreen()),
      );
    } else if (title == "Notifications") {

    //  FirebaseMessaging messaging = FirebaseMessaging.instance;
    //  NotificationSettings settings = await messaging.getNotificationSettings();
      /*if (settings.authorizationStatus == AuthorizationStatus.denied) {
        if (bloc.notification == false) {
          showAdaptiveDialog(context: context,
                      barrierDismissible: true,
                      builder: (context)=> AlertDialog.adaptive(
                        title: Text("\"Team Diary\" would like to send you notifications ",style: TextStyle(color: Colors.black),),
                        content: Text('Notifications may include alert sound and icon badges. This can be configured in settings.',style: TextStyle(color: Colors.black),),
                       actions: [
                         TextButton(onPressed:(){
                           Navigator.pop(context);
                         }, child: Text("Don't allow",style: TextStyle(color: AppColors.buttonBgColor4),)),
                         TextButton(onPressed:(){
                           Navigator.pop(context);
                            openAppSettings();
                         }, child: Text("OK",style: TextStyle(color: AppColors.buttonBgColor4),)),
                       ],
                      )
                  );
        } else {
          BlocProvider.of<UserProfileBloc>(context).add(UpdateNotificationEvent(mContext: context));
        }
      }*/
      // else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //   BlocProvider.of<UserProfileBloc>(context).add(UpdateNotificationEvent(mContext: context));
      // }
      // else {
      //   BlocProvider.of<UserProfileBloc>(context).add(UpdateNotificationEvent(mContext: context));
      // }


    } else if (title == "Delete Account") {
      showDialog(
          context: context,
          builder: (context) => WorkplaceWidgets.titleContentPopup(
                buttonName1: "Cancel",
                buttonName2: "Delete",
                title: AppString.trans(context, AppString.deletePopupTitle),
                content: AppString.trans(
                  context,
                  AppString.deletePopupContent,
                ),
                onPressedButton1: () {
                  BlocProvider.of<UserProfileBloc>(context)
                      .add(CancelEvent(mContext: context));
                },
                onPressedButton2: () =>
                    BlocProvider.of<UserProfileBloc>(context)
                        .add(DeleteUserEvent(mContext: context)),
              ));
    }
  }
}
