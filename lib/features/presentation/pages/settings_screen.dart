import 'package:workplace/imports.dart';

class SettingsScreen extends StatefulWidget {
  final String userName;
  final String email;
  final String image;

  const SettingsScreen({
    Key? key,
    this.userName = "Dino Waelchi",
    this.email = "Dino_waelchi@gmail.com",
    this.image =
        "https://instant-bollywood-1.s3.ap-south-1.amazonaws.com/wp-content/uploads/2021/08/14115151/aditya-kapoor.jpg",
  }) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  Map<String, File>? imageFile;
  Map<String, String>? imagePath;
  bool imageSelected = false;
  File? selectProfilePhoto;
  String? selectProfilePhotoPath;
  MainAppBloc? mainAppBloc;

  @override
  Widget build(BuildContext context) {
    //Return main Ui view
    return PopScope(
        onPopInvoked: null, //_onBackPressed,
        child: ContainerFirst(
            contextCurrentView: context,
            isSingleChildScrollViewNeed: true,
            isFixedDeviceHeight: true,
            appBarHeight: 50,
            appBar: const CommonAppBar(
              title: AppString.settings,
              icon: WorkplaceIcons.backArrow,
            ),
            containChild: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfileListRowWidget(
                  isHideIconVisible: true,
                  onClickListCallBack: (title) {
                    redirectTo(title, context);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                // version
              ],
            )));
  }

  void redirectTo(title, context) {
    if (title == "Change Password") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(widget: const ChangePasswordScreen()),
      );
    } else if (title == "Events") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(widget: const EventScreen()),
      );
    } else if (title == "Gallery") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(widget: const GalleryScreen()),
      );
    } else if (title == "FAQ") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(widget: const FaqScreen()),
      );
    } else if (title == "About Us") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(widget: const AboutApp()),
      );
    } else if (title == "Logout") {
      showModalBottomSheet(
          context: context,
          builder: (context) => const LogOutBottomSheetScreen(),
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
    }
  }
}
