// import 'package:cached_network_image/cached_network_image.dart';
import 'package:workplace/imports.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailBottomSheet extends StatefulWidget {
  final User userData;

  const UserDetailBottomSheet({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<UserDetailBottomSheet> createState() => _UserDetailBottomSheetState();
}

class _UserDetailBottomSheetState extends State<UserDetailBottomSheet> {
  bool isReadMore = false;

  makingPhoneCall() async {
    var url = Uri.parse('tel:${widget.userData.phone}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  email() async {
    var url = Uri.parse('mailto:${widget.userData.email}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget emailPhoneIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: email,
              child: const Icon(
                Icons.email,
                color: AppColors.appGreen,
                size: 32,
              )),
          const SizedBox(
            width: 8,
          ),
          InkWell(
              onTap: makingPhoneCall,
              child: const Icon(
                Icons.call,
                color: AppColors.appGreen,
                size: 30,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 50.sp),
            Container(
                padding: EdgeInsets.only(
                    left: 20.sp, right: 20.sp, top: 60.sp, bottom: 30.sp),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.appWhite,
                    ),
                    color: AppColors.appWhite,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                child: Column(
                  children: [
                    Text(
                      '${widget.userData.name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.appBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    Text(
                      '${widget.userData.email}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColors.appBlack,
                          fontWeight: FontWeight.normal),
                    ),
                    Text('${widget.userData.jobTitle}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColors.appBlack,
                            fontWeight: FontWeight.normal)),
                    SizedBox(
                      height: 10.sp,
                    ),
                    (widget.userData.phone != "" &&
                            widget.userData.phone != null)
                        ? RowTextWidget(
                            onIconTapCallBack: () async {
                              await makingPhoneCall();
                            },
                            iconData: Icons.call,
                            leftText: AppString.phone,
                            rightText:
                                '+${widget.userData.countryCode}  ${widget.userData.phone}',
                          )
                        : const SizedBox(),
                    isReadMore
                        ?
                    Column(
                            children: [
                              (widget.userData.doj != "" &&
                                      widget.userData.doj != null)
                                  ? RowTextWidget(
                                      leftText: AppString.doj,
                                      rightText: WorkplaceWidgets.formatDates(
                                          '${widget.userData.doj}'))
                                  : const SizedBox(),
                              (widget.userData.skills != "" &&
                                      widget.userData.skills != null)
                                  ? RowTextWidget(
                                      leftText: AppString.skills,
                                      rightText: widget.userData.skills,
                                    )
                                  : const SizedBox(),
                              (widget.userData.address != "" &&
                                      widget.userData.address != null)
                                  ? RowTextWidget(
                                      leftText: AppString.address,
                                      rightText: widget.userData.address,
                                    )
                                  : const SizedBox(),
                              (widget.userData.alternativeAddress != "" &&
                                      widget.userData.alternativeAddress !=
                                          null)
                                  ? RowTextWidget(
                                      leftText: AppString.alternateAddress,
                                      rightText:
                                          widget.userData.alternativeAddress,
                                    )
                                  : const SizedBox(),
                              (widget.userData.alternativePhone != "" &&
                                      widget.userData.alternativePhone != null)
                                  ? RowTextWidget(
                                      onIconTapCallBack: () {
                                        makingPhoneCall();
                                      },
                                      iconData: Icons.call,
                                      leftText: AppString.alternatePhone,
                                      rightText:
                                          '+${widget.userData.countryCode} ${widget.userData.alternativePhone}',
                                    )
                                  : const SizedBox(),
                              (widget.userData.dob != "" &&
                                      widget.userData.dob != null)
                                  ? RowTextWidget(
                                      leftText: AppString.dob,
                                      rightText: WorkplaceWidgets.formatDates(
                                          '${widget.userData.dob}'))
                                  : const SizedBox(),
                              (widget.userData.marriageAnniversaryDate != "" &&
                                      widget.userData.marriageAnniversaryDate !=
                                          null)
                                  ? RowTextWidget(
                                      leftText: AppString.marriageAnniversary,
                                      rightText: WorkplaceWidgets.formatDates(
                                          '${widget.userData.marriageAnniversaryDate}'))
                                  : const SizedBox(),
                              (widget.userData.skype != "" &&
                                      widget.userData.skype != null)
                                  ? RowTextWidget(
                                      leftText: AppString.skype,
                                      rightText: widget.userData.skype,
                                    )
                                  : const SizedBox(),
                              (widget.userData.githubUsername != "" &&
                                      widget.userData.githubUsername != null)
                                  ? RowTextWidget(
                                      leftText: AppString.githubUsername,
                                      rightText: widget.userData.githubUsername,
                                    )
                                  : const SizedBox(),
                              (widget.userData.bitbucketUsername != "" &&
                                      widget.userData.bitbucketUsername != null)
                                  ? RowTextWidget(
                                      leftText: AppString.gitBucketUserName,
                                      rightText:
                                          widget.userData.bitbucketUsername,
                                    )
                                  : const SizedBox(),
                              (widget.userData.leads!.isNotEmpty)
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 6.sp,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('Manager/Leads',
                                                textAlign: TextAlign.start,
                                                style:
                                                    appStyles.userNameTextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp)),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                widget.userData.leads!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 8.sp, top: 4.sp),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50), //18
                                                      child: Image.network(
                                                        // placeholder: (context,
                                                        //         url) =>
                                                        //     const ImageLoader(),
                                                        height: 40,
                                                        width: 40,
                                                         widget
                                                                .userData
                                                                .leads![index]
                                                                .profilePhoto ??
                                                            "",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20.sp,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              widget
                                                                      .userData
                                                                      .leads![
                                                                          index]
                                                                      .name ??
                                                                  '',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.sp)),
                                                          Text(
                                                            widget
                                                                    .userData
                                                                    .leads![
                                                                        index]
                                                                    .jobTitle ??
                                                                '',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .6)),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    )
                                  : SizedBox(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isReadMore = false;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      AppString.lessDetails,
                                      style:
                                          TextStyle(color: AppColors.appBlueA),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_up_outlined,
                                      color: AppColors.appBlueA,
                                      size: 30.sp,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                isReadMore = true;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  AppString.moreDetails,
                                  style: TextStyle(color: AppColors.appBlueA),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.appBlueA,
                                  size: 30.sp,
                                )
                              ],
                            ),
                          ),
                  ],
                )),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3))
            ],
            border: Border.all(color: AppColors.appWhite, width: 4),
            color: AppColors.appGrey,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FullPhotoView(
                      profileImgUrl:widget.userData.gender == 'female' ?"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU" :  '${widget.userData.profilePhoto}')));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                // placeholder: (context, url) => const ImageLoader(),
                height: 100.sp,
                width: 100.sp,
                widget.userData.gender == 'female' ?"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPhFl6zHkAHKFN0kNZl0jhZLfgeYYy2WzbezLIKbdF0eBJgVBP0ZmkVClZuU61_fF1bSc&usqp=CAU" : '${widget.userData.profilePhoto}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
