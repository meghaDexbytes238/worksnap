
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/util/app_theme/app_color.dart';
import '../../../core/util/app_theme/app_dimens.dart';
import '../../../core/util/workplace_icon.dart';

class NotificationBal2 extends StatelessWidget {
  final String? iconData;
  final VoidCallback? onTap;
  final int notificationCount;
  final double? rightIconSize;
  final double? rightIconBoxSize;
  final double? countTextSize;
  final Color? boxShapeCircleColor;
  final Color? iconDataColor;
  const NotificationBal2(
      {Key? key,
        this.onTap,
        this.iconData,
        this.rightIconSize,
        this.rightIconBoxSize,
        this.iconDataColor,
        this.notificationCount = 0,
        this.countTextSize,
        this.boxShapeCircleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    double? rightIconSizeTemp = rightIconBoxSize ?? (rightIconSize ?? 30.0);

    Widget menuIcon = iconData != null
        ? (iconData!.contains(".svg")
        ? SvgPicture.asset(iconData!,
        width: rightIconSize ?? AppDimens().iconSquareCustom(value: 18),
        height: rightIconSize ?? AppDimens().iconSquareCustom(value: 18),
        color: iconDataColor,
        fit: BoxFit.scaleDown)
        : Image(
      image: AssetImage(iconData!),
      width: rightIconSize ?? AppDimens().iconSquareCustom(value: 18),
      height: rightIconSize ?? AppDimens().iconSquareCustom(value: 18),
      color: iconDataColor,
    ))
        : Container(
      child: WorkplaceIcons.iconImage(
        imageUrl:  WorkplaceIcons.notificationIcon,
        imageColor: AppColors.black,
        iconSize: const Size(25, 25), //imageColor:Colors.white
      ),
    );

    return InkWell(
      onTap: onTap,
      child: Container(
        width: rightIconSizeTemp,
        padding:  EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[menuIcon],
            ),
            notificationCount > 0
                ? Positioned(
              top: 5,
              right: 5,
              child: Container(
                margin: const EdgeInsets.only(top: 2,right: 4),
                child: Container(
                  //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: boxShapeCircleColor ?? AppColors.appRed),
                  alignment: Alignment.center,
                  child: Container(
                      margin: const EdgeInsets.all(4),
                      child: Center(
                        child: Text(
                            '${notificationCount <= 99 ? notificationCount : "99+"}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:notificationCount <= 99 ? 12:8,
                                color: Colors
                                    .white /*,backgroundColor: Colors.red*/
                            )),
                      )),
                ),
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
