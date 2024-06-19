import 'package:flutter/cupertino.dart';
import 'package:workplace/imports.dart';

class MemberHeader extends StatefulWidget {
  final String name;
  final String imageUrl;
  const MemberHeader({super.key, required this.name, required this.imageUrl});

  @override
  State<MemberHeader> createState() => _MemberHeaderState();
}

class _MemberHeaderState extends State<MemberHeader> {
  double? segmentWidth;
  @override
  Widget build(BuildContext context) {
    segmentWidth = MediaQuery.of(context).size.width / 2.5;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0)
          .copyWith(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: segmentWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.sp,
                    ),
                    Container(
                      height: 85.sp,
                      width: 85.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white.withOpacity(0.2),
                        // gradient: LinearGradient(
                        //     begin:Alignment.topRight,
                        //     end: Alignment.bottomLeft,
                        //     colors: [
                        //       appColors.buttonBgColor4,
                        //       Color(0xFF6D23FF),
                        //     ]
                        // ),
                      ),
                      child: CircularImage(
                        height: 80.sp,
                        width: 80.sp,
                        image: widget.imageUrl ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU",
                        name: "",
                        isClickToFullView: true,
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.sp),
                              bottomLeft: Radius.circular(8.sp))),
                      child: Padding(
                        padding: EdgeInsets.all(4.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text((widget.name ?? "Kimberly Spalino"),
                                textAlign: TextAlign.start,
                                style: appStyles.userNameTextStyle(
                                    fontSize: 20.sp)),
                            Text("Senior Software Engineer",
                                textAlign: TextAlign.start,
                                style: appStyles.userNameTextStyle(
                                    fontSize: 12.sp)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return  MemberDetails();
                      });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 35.sp),
                  decoration: BoxDecoration(
                    color: AppColors.buttonBgColor4,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(05.sp),
                      bottomRight: Radius.circular(05.sp),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(-10, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WorkplaceWidgets.iconTextRowWidget(
                        icon: CupertinoIcons.mail_solid,
                        title: "john.dexbytes@gmail.com",
                        color: AppColors.white,
                        width: segmentWidth! + 5.sp,
                      ),
                      WorkplaceWidgets.iconTextRowWidget(
                        icon: CupertinoIcons.location_solid,
                        title: "Baneshwor kathmandu",
                        color: AppColors.white,
                        width: segmentWidth! + 5.sp,
                      ),
                      WorkplaceWidgets.iconTextRowWidget(
                        icon: Icons.cake,
                        title: "July 12 1998",
                        color: AppColors.white,
                        width: segmentWidth! + 5.sp,
                      ),
                      WorkplaceWidgets.iconTextRowWidget(
                        icon: CupertinoIcons.book_fill,
                        title: "UI, Figma, Sketch",
                        color: AppColors.white,
                        width: segmentWidth! + 5.sp,
                      ),
                      WorkplaceWidgets.iconTextRowWidget(
                        icon: CupertinoIcons.briefcase_fill,
                        title: "Engineering",
                        color: AppColors.white,
                        width: segmentWidth! + 5.sp,
                      ),
                      WorkplaceWidgets.iconTextRowWidget(
                        icon: CupertinoIcons.device_phone_portrait,
                        title: "+91 7157 942 310",
                        color: AppColors.white,
                        width: segmentWidth! + 5.sp,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
