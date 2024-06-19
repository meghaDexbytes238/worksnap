import 'package:workplace/imports.dart';

class CustomCountryPicker extends StatelessWidget {
  final String? text;
  final String? initialSelection;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final void Function(CountryCode)? onChanged;
  final void Function(CountryCode?)? onInit;

  const CustomCountryPicker({
    Key? key,
    this.text,
    this.textStyle,
    this.margin = const EdgeInsets.symmetric(horizontal: 21),
    this.padding = const EdgeInsets.symmetric(horizontal: 21),
    this.initialSelection,
    this.onChanged,
    this.onInit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.only(top: 0, left: 9, right: 0),
      child: Stack(
        children: [
          Padding(
            padding: padding,
            child: VerticalDivider(
              width: 5,
              thickness: 1.1,
              endIndent: 0,
              indent: 0,
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          CountryCodePicker(
              enabled: false,
              searchDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Search country code",
                  hintStyle: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSubHeading, //Color(0xff828588),
                  ),
                  fillColor: AppColors.textFiledColor.withOpacity(0.1),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12))),
              dialogSize: Size(AppDimens().widthFullScreen() / 1.15,
                  AppDimens().heightFullScreen() / 3.8),
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              countryFilter: ['In'],
              initialSelection: initialSelection,
              showCountryOnly: false,
              showFlag: true,
              flagWidth: 21,
              showFlagDialog: true,
              showOnlyCountryWhenClosed: false,
              dialogBackgroundColor:
                  !isDarkMode ? Colors.white : AppColors.appBgColor4,
              dialogTextStyle: TextStyle(
                  fontSize: 16,
                  color: !isDarkMode ? Colors.black : Colors.white),
              closeIcon: const Icon(Icons.clear, size: 26, color: Colors.black),
              hideSearch: true,
              hideMainText: false,
              textStyle: TextStyle(
                  fontSize: 15,
                  color: !isDarkMode ? Colors.black : Colors.white),
              onChanged: onChanged,
              onInit: onInit
              // flagWidth: ,
              ),
        ],
      ),
    );
  }
}
