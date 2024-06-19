import 'package:flutter/cupertino.dart';
import 'package:workplace/imports.dart';

class HomeTopCardView extends StatefulWidget {
  final onClickCardCallBack;
  final bool isFeatureVisible;
  final bool isSubtitleVisible;
  final bool isSecondDataVisible;
  final bool isBorderSelectVisible;
  final TextStyle titleTextStyle;
  final TextStyle? titleAfterSelectTextStyle;
  final TextStyle subtitleTextStyle;
  final EdgeInsetsGeometry padding;
  final Color borderColor;
  final double height;
  final double width;

  HomeTopCardView({
    Key? key,
    this.onClickCardCallBack,
    this.isFeatureVisible = true,
    this.titleTextStyle = const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff828588)),
    this.subtitleTextStyle = const TextStyle(
        fontSize: 12.5, fontWeight: FontWeight.w400, color: Color(0xffCBAD90)),
    this.isSubtitleVisible = false,
    this.isSecondDataVisible = false,
    this.padding = const EdgeInsets.only(left: 10),
    this.borderColor = const Color(0xffCBAD90),
    this.height = 60,
    this.width = 60,
    this.isBorderSelectVisible = false,
    this.titleAfterSelectTextStyle,
  }) : super(key: key);

  @override
  State<HomeTopCardView> createState() => _HomeTopCardViewState();
}

class _HomeTopCardViewState extends State<HomeTopCardView> {
  int selectImage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 140.sp,
          width: 80.sp,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(left: 4, right: 4),
          decoration: BoxDecoration(
              //color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://www.mecgale.com/wp-content/uploads/2017/08/dummy-profile.png'),
                fit: BoxFit.cover,
              )),
        ),
        Padding(
          padding: EdgeInsets.only(right: 2.sp),
          child: Card(
              elevation: 0,
              color: AppColors.bottomBarSelectedItemTextColor,
              child: Padding(
                padding: EdgeInsets.all(4.sp),
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
              )),
        )
      ],
    );
  }
}
