import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class WorkplaceIcons {
  static const String backArrow = 'assets/images/back_arrow_workplace.svg';
  static const String emailIcon = 'assets/images/email_icon.svg';
  static const String passwordIcon = 'assets/images/password_icon.svg';
  static const String moreIcon = 'assets/images/more_icon.svg';
  static const String commentIcon = 'assets/images/comment_icon.svg';
  static const String crossIcon = 'assets/images/cross_icon.svg';
  static const String editIcon = 'assets/images/edit_icon_4.svg';
  static const String galleryIcon = 'assets/images/photos_icon.svg';
  static const String cameraIcon = 'assets/images/camera_icon.svg';
  static const String calendarIcon = 'assets/images/calendar_icon.png';
  static const String settingsIcon = 'assets/images/setting_icon.svg';
  static const String shareIcon = 'assets/images/share_icon.svg';
  static const String reportIcon = 'assets/images/report_icon.svg';
  static const String notificationIcon = 'assets/images/notification_icon.svg';
  static const String logOutIcon = 'assets/images/log_out_icon.svg';
  static const String approveIcon = 'assets/images/approve_icon_3.svg';
  static const String briefcaseIcon = 'assets/images/briefcase_icon.svg';
  static const String clockIcon = 'assets/images/clock_icon.svg';
  static const String dexBytesIcon = 'assets/images/dexbytes_logo.svg';
  static const String cardBackgroundImages = 'assets/images/card_background.svg';
  static const String birthdayIcon='assets/images/birthday_cake_icon.svg';
  static const String birthdayCakeIcon='assets/images/profile_birthday_cake.svg';
  static const String anniversaryIcon='assets/images/anniversary_icon.svg';
  static const String calendarImage='assets/images/holiday_calendar.svg';
  static const String holidayIcon='assets/images/holiday_icon.svg';
  static const String leaveIcon='assets/images/leave_icon.svg';
  static const String homeWorkIcon='assets/images/home_work_icon.svg';
  static const String whfIcon='assets/images/wfh_icon.svg';
  static const String announcementIcon='assets/images/announcement_icon.svg';
  //static const String dexbytesImage='assets/images/dexbytes.svg';
static const String docFormat = 'assets/images/docx-file.svg';
static const String pdfFormat = 'assets/images/pdf_file.svg';//'assets/images/pdf_document.svg';
static const String imageFormat = 'assets/images/image_document.svg';
static const String downloadIcon = 'assets/images/file_download.svg';
static const String boxIcon = 'assets/images/empty_box.svg';

  static dynamic iconImage(
      {required String imageUrl,
      Size? iconSize,
      Color? imageColor,
      bool isFile = false}) {
    return isFile
        ? FileImage(
            File(imageUrl),
            scale: 1,
          )
        : (iconSize != null
            ? (imageUrl.contains(".svg")
                ? SvgPicture.asset(
                    imageUrl,
                    height: iconSize.height,
                    width: iconSize.width,
                    color: imageColor,
                  )
                : Image(
                    image: AssetImage(imageUrl),
                    height: iconSize.height,
                    width: iconSize.height,
                    color: imageColor,
                  ))
            : (imageUrl.contains(".svg")
                ? SvgPicture.asset(
                    imageUrl,
                    color: imageColor,
                  )
                : Image(
                    image: AssetImage(imageUrl),
                    color: imageColor,
                  )));
  }

  static SvgPicture iconImageProvider(
      {required String imageUrl,
      Size? iconSize,
      Color? imageColor,
      bool? isFile = false}) {
    return SvgPicture.asset(
      imageUrl,
      height: iconSize?.height,
      width: iconSize?.width,
      color: imageColor,
    );
  }
}
