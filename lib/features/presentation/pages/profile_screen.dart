import 'package:workplace/imports.dart';

class UserProfileScreen extends StatefulWidget {
  final String userName;
  final String email;
  final String image;

  const UserProfileScreen({
    Key? key,
    this.userName = "Dino Waelchi",
    this.email = "Dino_waelchi@gmail.com",
    this.image =
        "https://instant-bollywood-1.s3.ap-south-1.amazonaws.com/wp-content/uploads/2021/08/14115151/aditya-kapoor.jpg",
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  Map<String, File>? imageFile;
  Map<String, String>? imagePath;
  File? selectProfilePhoto;
  String? selectProfilePhotoPath;
  String userName = "";
  String email = "";
  late UserProfileBloc bloc;
  MainAppBloc mainAppBloc = MainAppBloc();
  late MainAppStateModel mainAppModel;
  UserResponseModel userResponseModel = UserResponseModel();
  String getImages = '';

  _UserProfileScreenState() {
    mainAppModel = mainAppBloc.state.getMainAppStateModel;
  }
  Future<String> getImage() async {
    await PrefUtils()
        .readStr(WorkplaceNotificationConst.userProfileImageC)
        .then((value) => getImages = value);
    return getImages;
  }

  @override
  void initState() {
    // TODO: implement initState
    bloc = BlocProvider.of<UserProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void photoPickerBottomSheet() {
      showModalBottomSheet(
          context: MainAppBloc.getDashboardContext,
          builder: (context1) => PhotoPickerBottomSheet(
            isRemoveOptionNeeded: false,
            removedImageCallBack: () {
              Navigator.pop(context1);
              setState(() {
                selectProfilePhotoPath = "";
              });
            },
            selectedImageCallBack: (fileList) {
              try {
                if (fileList != null && fileList.length > 0) {
                  fileList.map((fileDataTemp) {
                    File imageFileTemp = File(fileDataTemp.path);
                    selectProfilePhoto = imageFileTemp;
                    selectProfilePhotoPath = selectProfilePhoto!.path;
                    if (imageFile == null) {
                      imageFile = new Map();
                    } else {
                      imageFile!.clear();
                    }
                    if (imagePath == null) {
                      imagePath = new Map();
                    } else {
                      imagePath!.clear();
                    }
                    String mapKey =
                    DateTime.now().microsecondsSinceEpoch.toString();
                    imageFile![mapKey] = imageFileTemp; // = imageFileTemp;
                    imagePath![mapKey] = imageFileTemp.path;
                  }).toList(growable: false);
                  setState(() {});
                  BlocProvider.of<UserProfileBloc>(context).add(UploadMediaEvent(imagePath: imagePath!.values.first, mContext: context));
                }
              } catch (e) {
                print(e);
              }
              Navigator.pop(context1);
            },
            selectedCameraImageCallBack: (fileList) {
              try {
                if (fileList != null && fileList.path!.isNotEmpty) {
                  File imageFileTemp = File(fileList.path!);
                  selectProfilePhoto = imageFileTemp;
                  selectProfilePhotoPath = selectProfilePhoto!.path;
                  if (imageFile == null) {
                    imageFile = {};
                  } else {
                    imageFile!.clear();
                  }
                  if (imagePath == null) {
                    imagePath = {};
                  } else {
                    imagePath!.clear();
                  }
                  String mapKey =
                  DateTime.now().microsecondsSinceEpoch.toString();
                  imageFile![mapKey] = imageFileTemp; // = imageFileTemp;
                  imagePath![mapKey] = imageFileTemp.path;
                  setState(() {});
                  BlocProvider.of<UserProfileBloc>(context).add(UploadMediaEvent(imagePath: imagePath!.values.first, mContext: context));
                }
              } catch (e) {
                print(e);
              }
              Navigator.pop(context1);
            },
          ),
          isScrollControlled: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(photoPickerBottomSheetCardRadius))));
    }
    Widget profileImage() =>
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 19)
                .copyWith(top: 16, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                      bloc:bloc,
                      builder: (context, state) {
                        if (state is StoreMediaState) {
                          // imageSelected=true;
                          PrefUtils()
                              .readStr(
                                  WorkplaceNotificationConst.userProfileImageC)
                              .then((value) {
                            selectProfilePhotoPath = value;
                          });
                          bloc.add(FetchProfileDetails(mContext: context));
                        }
                        return Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.buttonBgColor4.withOpacity(0.5),
                          ),
                          child: CircularImage(
                            height: 85,
                            width: 85,
                            image: selectProfilePhotoPath ?? bloc.selectProfilePhoto,
                            name: "",
                            isClickToFullView: true,
                          ),
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        photoPickerBottomSheet();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 1, left: 55),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            shape: BoxShape.circle,
                            color: AppColors.buttonBgColor4.withOpacity(0.9)),
                        child: WorkplaceIcons.iconImage(
                          iconSize: const Size(20, 20),
                          imageColor: Colors.white,
                          imageUrl: WorkplaceIcons.editIcon,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 15),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                          barrierColor: Colors.transparent.withOpacity(.2),
                          context: MainAppBloc.getDashboardContext,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                          ),
                          builder: (BuildContext context) {
                            return MemberDetails(
                              userDetails: bloc.user,
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( bloc.user.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: appStyles.userNameTextStyle(fontSize: 20)),
                          Text( bloc.user.jobTitle ?? "",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: appStyles.userJobTitleTextStyle(fontSize: 14)),
                          Text( bloc.user.email ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: appStyles.userJobTitleTextStyle(
                                  fontSize: 14, texColor: const Color(0xFF757575))),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );

    return BlocConsumer<UserProfileBloc, UserProfileState>(
      bloc: bloc,
      listener: (BuildContext context, UserProfileState state) {

      },
      builder: (context, state) {
        if (state is  UploadMediaState) {
          bloc.add(FetchProfileDetails(mContext: context));
          return Container();
        }
        if (state is UserProfileInitial) {
          bloc.add(FetchProfileDetails(mContext: context));
          return Container();
        }
        return Stack(
          children: [
            PopScope(
                onPopInvoked: null, //_onBackPressed,
                child: ContainerFirst(
                    contextCurrentView: context,
                    isSingleChildScrollViewNeed: true,
                    isFixedDeviceHeight: true,
                    isListScrollingNeed: false,
                    appBarHeight: -1,
                    appBar: Container(),
                    containChild: Container(
                      color: Colors.grey.shade50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          profileImage(),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            color: Colors.white,
                            child: ProfileListRowWidget(
                              onClickListCallBack: (title) {
                                redirectTo(title, context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ))
            ),
            if(state is UserProfileLoading) WorkplaceWidgets.progressLoader(context),
          ],
        );
      },
    );
  }

  void redirectTo(title, context) {
    MainAppBloc mainAppBloc = MainAppBloc();
    MainAppStateModel mainAppModel = mainAppBloc.state.getMainAppStateModel;
    // to navigate manage document screen

    // if(title=='Documents')
    //   {
    //     Navigator.of(MainAppBloc.getDashboardContext)
    //         .push(MaterialPageRoute(builder: (context) => const ManageDocumentScreen()));
    //   }
    if(title=='Manage Family')
      {
        Navigator.of(MainAppBloc.getDashboardContext)
            .push(MaterialPageRoute(builder: (context) => const ManageFamilyScreen()));
      }
    else if(title=='All Ticket')
      {
        Navigator.of(MainAppBloc.getDashboardContext)
            .push(MaterialPageRoute(builder: (context) => const AllTicketScreen()));
      }
    else if (title == "Events") {
      Navigator.of(MainAppBloc.getDashboardContext)
          .push(MaterialPageRoute(builder: (context) => const EventDetailScreen()));
    } else if (title == "Holidays") {
      Navigator.of(MainAppBloc.getDashboardContext).push(
          MaterialPageRoute(builder: (context) => const HolidayDetailScreen()));
    } else if (title == "Feed") {
      Navigator.of(MainAppBloc.getDashboardContext)
          .push(MaterialPageRoute(builder: (context) => const FeedScreen()));
    } else if (title == "Birthdays") {
      Navigator.of(MainAppBloc.getDashboardContext).push(MaterialPageRoute(
          builder: (context) => const BirthdayDetailScreen()));
    } else if (title == "Work Anniversaries") {
      Navigator.of(MainAppBloc.getDashboardContext).push(MaterialPageRoute(
          builder: (context) => const WorkAnniversaryDetailScreen()));
    } else if (title == "Marriage Anniversaries") {
      Navigator.of(MainAppBloc.getDashboardContext).push(MaterialPageRoute(
          builder: (context) => const MarriageAnniversaryDetailScreen()));
    }
    else if (title == "Settings") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(
            widget: ProfileSettingsScreen(
          enableDelete: bloc.user.enableDelete,
        )),
      );
    } else if (title == "FAQ") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(widget: const FaqScreen()),
      );
    } else if (title == "About Us") {
      Navigator.push(
        MainAppBloc.getDashboardContext,
        SlideRightRoute(widget: const AboutApp()),
      );
    } else if (title == "Logout") {
      showModalBottomSheet(
          context: MainAppBloc.getDashboardContext,
          builder: (context) => const LogOutBottomSheetScreen(),
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
    }
  }
}
