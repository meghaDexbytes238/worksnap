import 'package:workplace/imports.dart';

class PostMenuScreen extends StatefulWidget {
  final String mobileNumber;

  const PostMenuScreen({Key? key, this.mobileNumber = "9171579456"})
      : super(key: key);
  @override
  _PostMenuScreenState createState() => _PostMenuScreenState();
}

class _PostMenuScreenState extends State<PostMenuScreen> {
  Map<String, TextEditingController> controllers = {
    'caption': TextEditingController(),
  };

  Map<String, FocusNode> focusNodes = {
    'caption': FocusNode(),
  };

  Map<String, String> errorMessages = {
    'caption': "",
  };

  OverlayEntry? overlayEntry;

  @override
  void initState() {
    // TODO: implement initState
    focusNodes['caption']!.addListener(() {
      if (Platform.isIOS) {
        bool hasFocus = focusNodes['caption']!.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controllers['caption']?.dispose();
    super.dispose();
  }

  int activeIndex = 0;
  Map<String, File>? imageFile;
  Map<String, String>? imagePath;
  bool imageSelected = false;
  File? selectProfilePhoto;
  String? selectProfilePhotoPath;

  @override
  Widget build(BuildContext context) {
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);

    postTextField() {
      return Container(
        margin: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
        width: MediaQuery.of(context).size.width,
        child: CommonTextFieldWithError(
          focusNode: focusNodes['caption'],
          isShowBottomErrorMsg: true,
          errorMessages: errorMessages['caption']?.toString() ?? '',
          controllerT: controllers['caption'],
          borderRadius: 8,
          inputHeight: 110,
          errorLeftRightMargin: 0,
          maxCharLength: 1200,
          errorMsgHeight: 0,
          maxLines: 6,
          autoFocus: false,
          showError: true,
          showCounterText: true,
          capitalization: CapitalizationText.sentences,
          cursorColor: Colors.grey,
          enabledBorderColor: AppColors.textFiledBorderColor,
          focusedBorderColor: AppColors.textFiledBorderColor,
          backgroundColor: AppColors.appTransColor,
          textInputAction: TextInputAction.done,
          borderStyle: BorderStyle.solid,
          inputKeyboardType: InputKeyboardTypeWithError.multiLine,
          hintText: "Enter your caption here",
          hintStyle: appStyles.textFieldTextStyle(
              fontWeight: FontWeight.w300, texColor: const Color(0xFF252525)),
          textStyle: appStyles.textFieldTextStyle(fontWeight: FontWeight.w400),
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          onTextChange: (value) {
            // checkEmail(value, 'email', onchange: true);
          },
          onEndEditing: (value) {
            // checkEmail(value, 'email');
          },
        ),
      );
    }

    openImageGallery() async {
      // List<Media>? fileList;
      // try {
      //   fileList = await ImagesPicker.pick(
      //     count: 1,
      //     pickType: PickType.image,
      //     language: Language.System,
      //   );
      //
      //   if (fileList != null && fileList.isNotEmpty) {
      //     try {
      //       if (fileList.isNotEmpty) {
      //         fileList.map((fileDataTemp) {
      //           File imageFileTemp = File(fileDataTemp.path);
      //
      //           imageSelected = true;
      //           selectProfilePhoto = imageFileTemp;
      //           selectProfilePhotoPath = selectProfilePhoto!.path;
      //           if (imageFile == null) {
      //             imageFile = {};
      //           } else {
      //             imageFile!.clear();
      //           }
      //           if (imagePath == null) {
      //             imagePath = {};
      //           } else {
      //             imagePath!.clear();
      //           }
      //           String mapKey =
      //               DateTime.now().microsecondsSinceEpoch.toString();
      //           imageFile![mapKey] = imageFileTemp; // = imageFileTemp;
      //           imagePath![mapKey] = imageFileTemp.path;
      //         }).toList(growable: false);
      //         setState(() {});
      //       }
      //     } catch (e) {
      //       print(e);
      //     }
      //   }
      // } catch (e) {
      //   print(e);
      // }
    }

    openCamera() async {
      // List<Media>? fileList;
      // try {
      //   fileList = await ImagesPicker.openCamera(
      //     pickType: PickType.image,
      //     quality: 0.5,
      //   );
      //   if (fileList != null && fileList.isNotEmpty) {
      //     try {
      //       if (fileList.isNotEmpty) {
      //         fileList.map((fileDataTemp) {
      //           File imageFileTemp = File(fileDataTemp.path);
      //
      //           imageSelected = true;
      //           selectProfilePhoto = imageFileTemp;
      //           selectProfilePhotoPath = selectProfilePhoto!.path;
      //           if (imageFile == null) {
      //             imageFile = {};
      //           } else {
      //             imageFile!.clear();
      //           }
      //           if (imagePath == null) {
      //             imagePath = {};
      //           } else {
      //             imagePath!.clear();
      //           }
      //           String mapKey =
      //               DateTime.now().microsecondsSinceEpoch.toString();
      //           imageFile![mapKey] = imageFileTemp; // = imageFileTemp;
      //           imagePath![mapKey] = imageFileTemp.path;
      //         }).toList(growable: false);
      //         setState(() {});
      //       }
      //     } catch (e) {
      //       print(e);
      //     }
      //   }
      // } catch (e) {
      //   print(e);
      // }
    }

    createNewRowItems({icon, name, callback, isLastMenu = false}) {
      return GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 5),
          color: AppColors.appTransColor,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                height: appDimens.heightDynamic(value: 40),
                child: isLastMenu ? Container() : icon,
              ),
              const SizedBox(
                width: 5,
              ),
              Text("$name",
                  style: appStyles.imageSelectTextStyle(fontSize: 14.5)),
            ],
          ),
        ),
      );
    }

    imageView() => Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 500,
              width: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(selectProfilePhotoPath!)),
              )),
            ),
            selectProfilePhotoPath == ""
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        splashColor: AppColors.buttonBgColor4.withOpacity(0.2),
                        highlightColor:
                            AppColors.buttonBgColor4.withOpacity(0.2),
                        onTap: () {
                          setState(() {
                            selectProfilePhotoPath = "";
                            imageSelected = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: AppColors.appTransColor,
                          ),
                          child: WorkplaceIcons.iconImage(
                              imageUrl: WorkplaceIcons.crossIcon,
                              iconSize: const Size(15, 15),
                              imageColor: AppColors.black),
                        ),
                      ),
                    ),
                  )
          ],
        );

    mediaListWidget() => imageSelected
        ? imageView()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "Select the type of post you want to create ",
                  style: appStyles.imageSelectTextStyle(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              createNewRowItems(
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 3.8),
                    child: WorkplaceIcons.iconImage(
                        imageUrl: WorkplaceIcons.cameraIcon,
                        iconSize: const Size(26, 26),
                        imageColor: AppColors.textSubTextColor),
                  ),
                  name: "  Take a Photo",
                  callback: () {
                    openCamera();
                  }),
              const SizedBox(height: 10),
              createNewRowItems(
                  icon: WorkplaceIcons.iconImage(
                      imageUrl: WorkplaceIcons.galleryIcon,
                      iconSize: const Size(30, 32),
                      imageColor: AppColors.textSubTextColor),
                  name: "  Choose a Photo",
                  callback: () {
                    openImageGallery();
                  }),
              const SizedBox(
                height: 5,
              ),
            ],
          );

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: false,
      appBarHeight: 52,
      appBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Share Post",
              style: appStyles.userNameTextStyle(fontSize: 16),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Post",
                      style: appStyles.userNameTextStyle(
                          fontSize: 16, texColor: AppColors.buttonBgColor4),
                    ),
                  )),
            ),
          ],
        ),
      ),
      containChild: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          postTextField(),
          const SizedBox(
            height: 22,
          ),
          mediaListWidget()
        ],
      ),
    );
  }

  //for ios done button callback
  onPressCallback() {
    removeOverlay();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //for keyboard done button
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView(
            onPressCallback: onPressCallback,
            buttonName: "Done",
          ));
    });

    overlayState.insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }
}
