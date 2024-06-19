import 'package:workplace/imports.dart';

class RowTextWidget extends StatelessWidget {
  final String? leftText;
  final String? rightText;
  final String? imageUrl;
  final String? icon;
  final TextStyle? leftTextStyle;
  final TextStyle? rightTextStyle;
  final bool isHideBottomLine;
  final bool isShowIcon;
  final bool isShowImage;
  final bool isHideText;
  final Color? iconColor;
  final Size? iconSize;
  final onTapCallBack;
  final onIconTapCallBack;
  final IconData? iconData;
  final EdgeInsetsGeometry? padding;

  const RowTextWidget({
    Key? key,
    this.leftText,
    this.rightText,
    this.icon,
    this.leftTextStyle,
    this.rightTextStyle,
    this.isHideBottomLine = true,
    this.isHideText = false,
    this.iconColor,
    this.isShowIcon = false,
    this.isShowImage = false,
    this.iconSize,
    this.onTapCallBack,
    this.onIconTapCallBack,
    this.iconData,
    this.imageUrl,
    this.padding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          this.onTapCallBack?.call();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5,
                      color: isHideBottomLine
                          ? Colors.transparent
                          : !isDarkMode
                              ? Colors.grey.shade300
                              : Colors.grey.shade800))),
          padding: padding ?? const EdgeInsets.only(top: 9, bottom: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${leftText}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: leftTextStyle ?? appStyles.containerLeftTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Text(':',style: leftTextStyle ?? appStyles.containerLeftTextStyle(), ),
              const SizedBox(width: 8,),
              Expanded(
                flex: 5,
                child:
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    this.onIconTapCallBack?.call();
                  },
                  onDoubleTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text('${rightText}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: rightTextStyle ??
                              appStyles.containerRightTextStyle(
                                  texColor: Colors.black87),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(width: 8,),
                      // InkWell(
                      //    splashColor: Colors.transparent,
                      //    highlightColor: Colors.transparent,
                      //    onTap: () {
                      //      this.onIconTapCallBack?.call();
                      //    },
                          //child:
                          Icon(iconData,color: Colors.green.shade600,size: 20,)
                      //)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
