class UserProfileRawDataModel {
  final String title;
  final String icon;

  UserProfileRawDataModel({
    required this.title,
    required this.icon,
  });
}

List<UserProfileRawDataModel> userProfile = [
// UserProfileRawDataModel(
//   title: "My Post",
//   icon: 'assets/images/my_post_icon.svg',
// ),
//   UserProfileRawDataModel
//     (
//     title: "Documents",
//     icon: 'assets/images/documents_icon.svg',
//   ),
  UserProfileRawDataModel(
    title: "Manage Family",
    icon: 'assets/images/family1.svg',
  ),
  // UserProfileRawDataModel(
  //   title: "All Ticket",
  //   // icon: 'assets/images/ticket.svg',
  //   icon: 'assets/images/ticket_icon.svg',
  // ),
  UserProfileRawDataModel(
    title: "Events",
    icon: 'assets/images/event_icon_2.svg',
  ),
  UserProfileRawDataModel(
    title: "Holidays",
    icon: 'assets/images/event_icon_2.svg',
  ),
  UserProfileRawDataModel(
    title: "Feed",
    icon: 'assets/images/feed_icon.svg',
  ),
// UserProfileRawDataModel(
//   title: "Birthdays",
//   icon: 'assets/images/profile_birthday_cake.svg',
// ),
// UserProfileRawDataModel(
//   title: "Work Anniversaries",
//  icon: 'assets/images/gift_box.svg',
// ),
// UserProfileRawDataModel(
//   title: "Marriage Anniversaries",
//   icon: 'assets/images/gift_box.svg',
// ),
// UserProfileRawDataModel(
//   title: "Gallery",
//   icon: 'assets/images/photos_icons.svg',
// ),
  UserProfileRawDataModel(
    title: "Settings",
    icon: 'assets/images/setting_icon.svg',
  ),
  UserProfileRawDataModel(

    title: "FAQ",
    icon: 'assets/images/faq.svg',
  ),
  UserProfileRawDataModel(
    title: "About Us",
    icon: 'assets/images/about.svg',
  ),
  UserProfileRawDataModel(
    title: "Logout",
    icon: 'assets/images/log_out_icon.svg'
    ,
  )
  ,
];
