// import 'package:cached_network_image/cached_network_image.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:workplace/imports.dart';
import '../pages/user_detail_bottom_sheet.dart';

abstract class WorkplaceWidgets {
  static Widget iconTextRowWidget(
          {required IconData icon,
          required String title,
          Color? color,
          double? width}) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: 15.sp,
            color: color ?? AppColors.buttonBgColor4.withOpacity(0.5),
          ),
          SizedBox(
            width: 5.sp,
          ),
          SizedBox(
            width: width,
            child: Text(title,
                textAlign: TextAlign.start,
                style: appStyles.userJobTitleTextStyle(
                    fontSize: 12.sp, texColor: color)),
          ),
        ],
      );

  AppStyle appStyle = AppStyle();

  static Widget titleContentPopup({
    required String buttonName1,
    required String buttonName2,
    required String title,
    required String content,
    Function()? onPressedButton1,
    Function()? onPressedButton2,

  }) =>
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(title, textAlign: TextAlign.center),
        titleTextStyle: appStyles.titleStyle(
          fontSize: AppDimens().fontSize(value: 22),
          fontWeight: FontWeight.w500,
          texColor: AppColors.black,
          fontFamily: AppFonts().defaultFont,
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
        contentTextStyle: appStyles.subTitleStyle(
          fontSize: AppDimens().fontSize(value: 16),
          fontWeight: FontWeight.w200,
          texColor: AppColors.black,
          fontFamily: AppFonts().defaultFont,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: onPressedButton1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                          width: 1,
                          color: AppColors.appBlue,
                        ),
                        color: Colors.transparent),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        buttonName1,
                        style: appStyles.subTitleStyle(
                          fontSize: AppDimens().fontSize(value: 15),
                          fontWeight: FontWeight.w500,
                          texColor: AppColors.appBlue,
                          fontFamily: AppFonts().defaultFont,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: GestureDetector(
                  onTap: onPressedButton2,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: AppColors.appRed),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        buttonName2,
                        style: appStyles.subTitleStyle(
                          fontSize: AppDimens().fontSize(value: 15),
                          fontWeight: FontWeight.w500,
                          texColor: AppColors.appWhite,
                          fontFamily: AppFonts().defaultFont,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  static userDetailBottomSheet({required User userData}) {
    showModalBottomSheet(
        barrierColor: Colors.transparent.withOpacity(.2),
        context: MainAppBloc.getDashboardContext, // is used to remove Bottom Navigation Bar
        builder: (context) => UserDetailBottomSheet(
              userData: userData,
            ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            //borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
        ));
  }

  static Widget userDetailListCard(
      {required User? user, required String description}) {
    var doc = parse(description);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: InkWell(
        onTap: () => WorkplaceWidgets.userDetailBottomSheet(
            userData: user ?? User()),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),//18
              child: Image.network(
                // placeholder: (context, url) => const ImageLoader(),
                height: 40,
                width: 40,
                user!.profilePhoto ??"",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 16.sp)
                  ),
                  Text(
                    doc.documentElement!.text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black.withOpacity(.6)
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget eventListCard(
      {
        required String startDate,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.sp,
            width: 40.sp,
            decoration: BoxDecoration(
                color: AppColors.buttonBgColor4, borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  startDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12.sp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title.trim(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 0.8,
                      color: Colors.black,
                      fontSize: 16.sp,
                    )),
                const SizedBox(height: 6,),
                Text(
                  description.trim(),
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      //height: 1.5,
                      color: Colors.black.withOpacity(.6)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget progressLoader(BuildContext context)=>  Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Colors.white.withOpacity(.2),
    child:  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          SizedBox(height: AppBar().preferredSize.height)
        ],
      ),
    ),
  );

  static Widget sliderChildren({Function()? onTap,required IconData icon,required String text,required Color iconColor}){
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        color: const Color(0xFFe5e5e5).withOpacity(0.5),
        padding: const EdgeInsets.only(top: 5),
        child:  Column(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            Text(
              text,
              style: TextStyle(color: iconColor),
            )
          ],
        ),
      ),
    );
  }


static Widget errorPage({Function()? onPressed, required String title, required String subTitle ,String? imageUrl })
{
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset( imageUrl ?? 'assets/images/wifi_logo.svg',
              height: 200,
              width: 200,
              ),
           Text(title,
            style: const TextStyle(
                color: Color(0xFF191D21),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
           Text(subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color(0xFF656F77),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12)),
                    foregroundColor: AppColors.white),
                onPressed: onPressed,
                child: const Text(
                  'Retry',
                  style: TextStyle(fontSize: 20),
                )),
          ),
        ],
      ),
    ),
  );
}

static Widget commonButton({required Function() onClickCallBack,required String? title, Color? fontColor,Color? bgColor ,Color? borderColor })
{
  return Material(
    borderRadius: BorderRadius.circular(4),
    color: bgColor ?? Colors.grey.shade100,
    child: InkWell(
      onTap: onClickCallBack,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all( width: 1, color: borderColor ?? Colors.grey.shade300),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8)),
        child: Text( title ?? "Cancel",
          style: appStyles.buttonTextStyle1(
              texColor: fontColor ??Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ),
      ),
    ),
  );
}

 static String parseDate(String inputDate) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    try {
      final parsedDate = inputFormat.parse(inputDate);
      return outputFormat.format(parsedDate);
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }
  static String formatDates(String inputString) {
    if (inputString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(inputString);

      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedDate;
    } else {
      return inputString;
    }
  }

}
