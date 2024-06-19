import 'package:workplace/features/presentation/bloc/notification_bloc/app_notification_event.dart';
import 'package:workplace/imports.dart';
import '../../bloc/notification_bloc/app_notification_bloc.dart';
import '../notification_bell_widget.dart';

class HomeScreenAppBar extends StatefulWidget {
  int notificationCount;

  HomeScreenAppBar({Key? key, required this.notificationCount})
      : super(key: key);

  @override
  State<HomeScreenAppBar> createState() => _HomeScreenAppBarState();
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 0.3,
        color: Colors.grey.shade300,
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("TEAMDIARY",
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 2.5,
                color: AppColors.textNormalColor1,
                fontSize: 23,
                fontFamily: "Caveat",
                fontWeight: FontWeight.w900,
              )),
          NotificationBal2(
            notificationCount: widget.notificationCount,
            rightIconBoxSize: 50,
            onTap: () {
              BlocProvider.of<AppNotificationBloc>(context).add(const MarkNotificationDisplayedEvent());
              Navigator.push(
                MainAppBloc.getDashboardContext,
                SlideRightRoute(widget: const NotificationScreen()),
              ).then((value) {
                if(value== true)
                  {
                    BlocProvider.of<UserProfileBloc>(context).add(FetchProfileDetails(mContext: context));
                  }
              });
            },
          ),
        ],
      ),
    );
  }
}
