import 'package:workplace/imports.dart';

class PaddingTextWidget extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;

  const PaddingTextWidget({
    Key? key,
    this.text,
    this.textStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Text("$text", style: textStyle ?? appStyles.titleStyle()),
    );
  }
}
