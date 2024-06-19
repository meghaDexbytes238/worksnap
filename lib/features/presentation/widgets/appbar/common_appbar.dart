import 'package:workplace/imports.dart';

class CommonAppBar extends StatelessWidget {
  final String? title;
  final double fontSize;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? icon;
  final EdgeInsetsGeometry? padding;
  final onLeftIconClickCallBack;
  final bool isHideIcon;
  final FontWeight fontWeight;
  const CommonAppBar(
      {Key? key,
      this.title,
      this.fontSize = 18,
      this.onLeftIconClickCallBack,
      this.textColor,
      this.icon,
      this.backgroundColor,
      this.iconColor,
      this.isHideIcon = false,
      this.padding,
      this.fontWeight = FontWeight.w800,
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      padding: padding ?? EdgeInsets.only(left: 5.0),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            isHideIcon
                ? Container()
                : IconButton(
                    splashRadius: 23,
                    onPressed: () {
                      Navigator.pop(context,true);
                    },
                    icon:const Icon(Icons.arrow_back_ios_new,color: Colors.black,),

                    // WorkplaceIcons.iconImage(
                    //   iconSize: const Size(14, 14),
                    //   imageColor: Colors.black,
                    //   imageUrl: icon ?? WorkplaceIcons.crossIcon,
                    // ),
                  ),
            const SizedBox(
              width: 12,
            ),
            Text(
              title ?? "Comments",
              style: appStyles.userNameTextStyle(
                  fontSize: 16,
                fontWeight: fontWeight,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
