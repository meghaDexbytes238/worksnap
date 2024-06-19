import 'package:workplace/features/data/models/profile_data_model.dart';
import 'package:workplace/imports.dart';

class ProfileListRowWidget extends StatelessWidget {
  final onClickListCallBack;
  final bool isHideIconVisible;

  ProfileListRowWidget(
      {Key? key, this.onClickListCallBack, this.isHideIconVisible = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    MainAppBloc mainAppBloc = MainAppBloc();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 50, top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userProfile.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade100,
            onTap: () {
              onClickListCallBack?.call(userProfile[index].title);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 21),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.27,
                          color: index == 7
                              ? Colors.white
                              : Colors.grey.shade400))),
              padding: const EdgeInsets.all(18)
                  .copyWith(left: 5, right: 5, bottom: index == 5 ? 10 : 18),
              child: Row(
                children: [
                  WorkplaceIcons.iconImage(
                    imageUrl: userProfile[index].icon,
                    iconSize: const Size(22, 22),
                    imageColor:
                        index == 7 ? Colors.red.shade800 : Colors.black87,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          userProfile[index].title,
                          textAlign: TextAlign.start,
                          style: appStyles.onBoardingTitleStyle(
                            fontSize: 14.5,
                            height: 1.1,
                            fontWeight: FontWeight.w400,
                            texColor: index == 7
                                ? Colors.red.shade800
                                : Colors.black.withOpacity(.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
