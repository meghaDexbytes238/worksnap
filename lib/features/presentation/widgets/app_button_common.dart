import 'package:workplace/imports.dart';

class AppButton extends StatefulWidget {
  final backCallback, buttonName;
  final Color? buttonColor;
  final bool isShowIcon;
  final String? icon;
  final Size? iconSize;
  final double? buttonHeight;
  final isDisable;
  const AppButton(
      {Key? key,
      this.backCallback,
      this.buttonName,
      this.buttonColor,
      this.buttonHeight,
      this.isShowIcon = false,
      this.icon,
      this.iconSize,
      this.isDisable = false})
      : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return CommonButton(
      isDisable: widget.isDisable,
      buttonHeight: widget.buttonHeight ?? 50,
      buttonName: widget.buttonName,
      buttonColor: widget.buttonColor ?? AppColors.buttonBgColor4,
      buttonBorderRadius: 8,
      textStyle: appStyles.buttonTextStyle1(),
      backCallback: widget.backCallback,
      isBottomMarginRequired: false,
      isShowIcon: widget.isShowIcon,
      iconSize: widget.iconSize,
      icon: widget.icon,
    );
  }
}
