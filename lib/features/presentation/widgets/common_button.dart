import 'package:workplace/imports.dart';

class CommonButton extends StatefulWidget {
  final backCallback, buttonName, isDisable, buttonColor;
  final bool isBottomMarginRequired;
  final Color buttonBorderColor;
  final double buttonBorderWidth;
  final double buttonBorderRadius;
  final double buttonHeight;
  final double buttonWidth;
  final bool isShowIcon;
  final String? icon;
  final Size? iconSize;
  final TextStyle? textStyle;
  const CommonButton(
      {Key? key,
      this.backCallback,
      this.buttonName,
      this.buttonBorderColor = Colors.transparent,
      this.buttonBorderWidth = 0,
      this.buttonHeight = -1,
      this.buttonWidth = -1,
      this.textStyle,
      this.isDisable = false,
      this.isBottomMarginRequired = true,
      this.buttonColor,
      this.buttonBorderRadius = 40,
      this.isShowIcon = false,
      this.icon,
      this.iconSize})
      : super(key: key);
  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    bool bottomViewPadding = isSafeAreaRequired(context: context);

    Color buttonColor = widget.buttonColor ?? AppColors.buttonBgColor;
    return Material(
        color: widget.isDisable ? buttonColor.withOpacity(0.4) : buttonColor,
        borderRadius: BorderRadius.circular(widget.buttonBorderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.buttonBorderRadius),
          onTap: () {
            widget.backCallback?.call();
          },
          child: Container(
            margin: EdgeInsets.only(
                bottom: widget.isBottomMarginRequired
                    ? (bottomViewPadding ? 70 : 60)
                    : 0),
            width: double.infinity,
            height: widget.buttonHeight >= 0
                ? widget.buttonHeight
                : AppDimens().buttonHeight(),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                // color: widget.isDisable ? buttonColor.withOpacity(0.4) : buttonColor,
                borderRadius: BorderRadius.circular(widget.buttonBorderRadius),
                border: Border.all(
                  color: widget.buttonBorderColor,
                  width: widget.buttonBorderWidth,
                )
//          //It is just a dummy image
                ),
            child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.isShowIcon
                        ? WorkplaceIcons.iconImage(
                            imageUrl: widget.icon ?? WorkplaceIcons.backArrow,
                            imageColor: Colors.white,
                            iconSize: widget.iconSize ?? Size(25, 25),
                          )
                        : Container(),
                    SizedBox(width: widget.isShowIcon ? 6 : 0),
                    Text(
                      widget.buttonName ??
                          AppString.trans(context, AppString.back),
                      style: widget.textStyle ??
                          TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ),
        ));
  }
}

bool isSafeAreaRequired({required BuildContext context}) {
  double bottomViewPadding = MediaQuery.of(context).viewPadding.bottom;
  return bottomViewPadding > 0 ? true : false;
}
