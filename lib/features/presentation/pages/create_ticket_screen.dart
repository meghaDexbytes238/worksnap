// import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import '../../../imports.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({Key? key}) : super(key: key);

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  OverlayEntry? overlayEntry;
  String? fileName;
  String? filePath;
  List<String> listOfFile = [];
  List<File> fileList = [];
  String selectFileErrorMessage = '';
  String ticketCategoryErrorMessage = '';
  String selectedTicketCategoryName = '';
  Map<String, TextEditingController> controllers = {
    'subject': TextEditingController(),
    'description': TextEditingController()
  };

  Map<String, FocusNode> focusNodes = {
    'subject': FocusNode(),
    'description': FocusNode()
  };

  Map<String, String> errorMessages = {'subject': "", 'description': ""};

  Widget ticketCategoryErrorText() => (ticketCategoryErrorMessage != '')
      ? Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 25, top: 2),
          height: 18,
          child: Text(
            ticketCategoryErrorMessage,
            style: appStyles.errorStyle(),
          ))
      : Container(height: 0.5);

  Widget selectFileErrorText() => (selectFileErrorMessage != '')
      ? Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 25, top: 2),
          height: 18,
          child: Text(
            selectFileErrorMessage,
            style: appStyles.errorStyle(),
          ))
      : Container(height: 0.5);

  subjectField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        // boxShadow:  [
        //   BoxShadow(
        //       color: Colors.grey.shade200,
        //       spreadRadius: 3,
        //       offset: Offset(0, 1),
        //       blurRadius: 3)
        // ]
      ),
      margin: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
      width: MediaQuery.of(context).size.width,
      child: CommonTextFieldWithError(
        focusNode: focusNodes['subject'],
        isShowBottomErrorMsg: true,
        errorMessages: errorMessages['subject']?.toString() ?? '',
        controllerT: controllers['subject'],
        borderRadius: 8,
        inputHeight: 50,
        errorLeftRightMargin: 0,
        maxCharLength: 1200,
        errorMsgHeight: 18,
        maxLines: 1,
        autoFocus: false,
        showError: true,
        showCounterText: false,
        capitalization: CapitalizationText.sentences,
        cursorColor: Colors.grey,
        enabledBorderColor: AppColors.white,
        focusedBorderColor: AppColors.white,
        backgroundColor: AppColors.white,
        textInputAction: TextInputAction.done,
        borderStyle: BorderStyle.solid,
        inputKeyboardType: InputKeyboardTypeWithError.text,
        hintText: "Subject",
        hintStyle: appStyles.textFieldTextStyle(
            fontWeight: FontWeight.w400,
            texColor: Colors.grey.shade600,
            fontSize: 14 ),
        textStyle: appStyles.textFieldTextStyle(fontWeight: FontWeight.w400),
        contentPadding:
            const EdgeInsets.only(left: 15, right: 15, top: -5, bottom: 0),
        onTextChange: (value) {
          checkSubject(value, 'subject', onchange: true);
        },
        onEndEditing: (value) {
          checkSubject(value, 'subject');
          FocusScope.of(context).requestFocus(focusNodes['subject']);
        },
      ),
    );
  }

  categories() {
    return DropDownDataPicker(
      //  borderColor: ticketCategoryErrorMessage != '' ? Colors.red : Colors.transparent,
      hint: 'First',
      itemList: const [
        DropdownMenuItem(
          value: 'First',
          child: Text('First'),
        ),
        DropdownMenuItem(
          value: 'Second',
          child: Text('Second'),
        ),
        DropdownMenuItem(
          value: 'Third',
          child: Text('Third'),
        ),
      ],
      selectedValue: (value) {
        setState(() {
          selectedTicketCategoryName = value;
          if (selectedTicketCategoryName.isEmpty) {
            ticketCategoryErrorMessage = "";
          } else {
            ticketCategoryErrorMessage = "";
          }
        });
      },
    );
  }

  descriptionField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.grey.shade200,
        //       spreadRadius: 3,
        //       offset: const Offset(0, 1),
        //       blurRadius: 3)
        // ]
      ),
      margin: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
      width: MediaQuery.of(context).size.width,
      child: CommonTextFieldWithError(
        controllerT: controllers['description'],
        focusNode: focusNodes['description'],
        errorMessages: errorMessages['description']!.toString(),
        errorLeftRightMargin: 0,
        errorMsgHeight: 18,
        showError: true,
        isShowBottomErrorMsg: true,
        inputHeight: 100,
        maxCharLength: 1200,
        maxLines: 5,
        inputKeyboardType: InputKeyboardTypeWithError.multiLine,
        textInputAction: TextInputAction.done,
        borderRadius: 8,
        cursorColor: Colors.grey,
        hintText: 'Description',
        hintStyle: appStyles.textFieldTextStyle(
            fontWeight: FontWeight.w400,
            texColor: Colors.grey.shade600,
            fontSize: 14),
        textStyle: appStyles.textFieldTextStyle(fontWeight: FontWeight.w400),
        contentPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        borderStyle: BorderStyle.solid,
        enabledBorderColor: Colors.white,
        focusedBorderColor: Colors.white,
        backgroundColor: Colors.white,
        capitalization: CapitalizationText.sentences,
        autoFocus: false,
        showCounterText: false,
        onTextChange: (value) {
          checkDescription(value, 'description', onchange: true);
        },
        onEndEditing: (value) {
          checkDescription(value, 'description');
          FocusScope.of(context).requestFocus(focusNodes['description']);
        },
      ),
    );
  }

  selectFile() async {
    Navigator.of(context).pop();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'svg'],
    );

    if (result != null) {
      // fileList.addAll(result.paths.map((path) => File(path!)).toList());
      //  listOfFile = List<String>.generate(fileList.length, (index) => fileList.elementAt(index).path);

      File files = File(result.files.single.path!);
      fileList.add(files);
      listOfFile = List<String>.generate(
          fileList.length, (index) => fileList.elementAt(index).path);

      PlatformFile file = result.files.first;
      setState(() {
        fileName = file.name;
        filePath = file.path;
        if (fileName!.isNotEmpty) {
          selectFileErrorMessage = '';
        }
      });
    } else {
      // User canceled the picker
    }
  }

  filePickerBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetOnlyCardView(
              sheetTitle:
                  "Select File" /* appString.trans(context, appString.selectPhoto)*/,
              sheetTitleStyle: appStyles.photoBottomSheetTitleStyle(),
              topLineShow: true,
              topLineMargin: const EdgeInsets.only(top: 8, bottom: 6),
              cardBackgroundColor: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: InkWell(
                      onTap: selectFile,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.storage,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Local Storage",
                            style: appStyles.subTitleStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                texColor: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ));
  }

  attachFile() {
    return InkWell(
      onTap: () async {
        if (listOfFile.length >= 5) {
        } else {
          filePickerBottomSheet();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 3,
                  offset: const Offset(0, 1),
                  blurRadius: 3)
            ]),
        margin: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
        padding: const EdgeInsets.only(left: 15, right: 25),
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text('Tapped to attach file',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appStyles.textFieldTextStyle(
                      fontWeight: FontWeight.w400,
                      texColor: Colors.grey.shade600,
                      fontSize: 14)),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.attach_file,
              color: Colors.grey.shade600,
            )
          ],
        ),
      ),
    );
  }

  bottomButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: AppButton(
        buttonName: 'Create Ticket',
        backCallback: () {
          if (validateFields(isButtonClicked: true)) {
            print('Ticket is Created........');
            Navigator.pop(context);
            Fluttertoast.showToast(
                backgroundColor: Colors.green.shade500,
                msg: "Ticket created successfully");
          }
        },
      ),
    );
  }

  checkSubject(value, fieldEmail, {onchange = false}) {
    if (Validation.isNotEmpty(value.trim())) {
      setState(() {
        if (Validation.isNotEmpty(value.trim())) {
          errorMessages[fieldEmail] = "";
        } else {
          if (!onchange) {
            errorMessages[fieldEmail] =
                AppString.trans(context, AppString.emailHintError1);
          }
        }
      });
    } else {
      setState(() {
        if (!onchange) {
          if (fieldEmail == 'subject') {
            errorMessages[fieldEmail] =
                AppString.trans(context, AppString.emailHintError);
          }
        }
      });
    }
  }

  checkDescription(value, fieldEmail, {onchange = false}) {
    if (Validation.isNotEmpty(value.trim())) {
      setState(() {
        if (Validation.isNotEmpty(value.trim())) {
          errorMessages[fieldEmail] = "";
        } else {
          if (!onchange) {
            errorMessages[fieldEmail] =
                AppString.trans(context, AppString.emailHintError1);
          }
        }
      });
    } else {
      setState(() {
        if (!onchange) {
          if (fieldEmail == 'description') {
            errorMessages[fieldEmail] =
                AppString.trans(context, AppString.emailHintError);
          }
        }
      });
    }
  }

  bool validateFields({isButtonClicked = false}) {
    if (controllers['subject']?.text == null ||
        controllers['subject']?.text == '') {
      setState(() {
        if (isButtonClicked) {
          FocusScope.of(context).requestFocus(focusNodes['subject']);
          errorMessages['subject'] = 'Please enter subject';
        }
      });
      return false;
    } else if (!Validation.isNotEmpty(controllers['subject']?.text ?? '')) {
      setState(() {
        if (isButtonClicked) {
          FocusScope.of(context).requestFocus(focusNodes['subject']);
          errorMessages['subject'] =
              AppString.trans(context, 'Please enter subject');
        }
      });

      return false;
    } else if (selectedTicketCategoryName.isEmpty) {
      if (isButtonClicked) {
        setState(() {
          ticketCategoryErrorMessage = "Please select ticket category";
        });
      }
      return false;
    } else if (controllers['description']?.text == null ||
        controllers['description']?.text == '') {
      setState(() {
        if (isButtonClicked) {
          FocusScope.of(context).requestFocus(focusNodes['description']);
          errorMessages['description'] = 'Please enter description';
        }
      });
      return false;
    } else if (!Validation.isNotEmpty(controllers['description']?.text ?? '')) {
      setState(() {
        if (isButtonClicked) {
          FocusScope.of(context).requestFocus(focusNodes['description']);
          errorMessages['description'] =
              AppString.trans(context, 'Please enter description');
        }
      });
      return false;
    } else if (fileName == null || fileName!.isEmpty) {
      if (isButtonClicked) {
        setState(() {
          selectFileErrorMessage = "Please select File";
        });
      }
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    focusNodes['subject']!.addListener(() {
      if (Platform.isIOS || Platform.isAndroid) {
        bool hasFocus = focusNodes['subject']!.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      }
    });
    focusNodes['description']!.addListener(() {
      if (Platform.isIOS || Platform.isAndroid) {
        bool hasFocus = focusNodes['description']!.hasFocus;
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
  Widget build(BuildContext context) {
    return ContainerFirst(
      contextCurrentView: context,
      appBarHeight: 50,
      appBar: const CommonAppBar(
        title: 'Create Ticket',
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          subjectField(),
          const SizedBox(
            height: 4,
          ),
          categories(),
          ticketCategoryErrorText(),
          const SizedBox(
            height: 19,
          ),
          descriptionField(),
          const SizedBox(
            height: 4,
          ),
          attachFile(),
          selectFileErrorText(),
          const SizedBox(
            height: 15,
          ),
          // Image.file(File('${filePath}'),height: 80,width: 80,fit: BoxFit.cover,),
          listOfFile.isEmpty
              ? Container()
              : SizedBox(
                  height: 90,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      itemCount: listOfFile.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            InkWell(
                              onTap: () {
                                //OpenFile.open("/data/user/0/com.dexbytes.workPlace/cache/file_picker/sample1.doc");
                              },
                              child: Row(
                                children: [
                                  (listOfFile[index].contains(".pdf"))
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),

                                          child: Image.network('https://i.pinimg.com/originals/c3/07/d1/c307d13aac792ea9cb9e1f8162a329b2.png',fit:BoxFit.cover,
                                            height: 80,
                                              width: 80,
                                          )
                                          // CachedNetworkImage(
                                          //   placeholder: (context, url) =>
                                          //       ImageLoader(),
                                          //   imageUrl:
                                          //       'https://i.pinimg.com/originals/c3/07/d1/c307d13aac792ea9cb9e1f8162a329b2.png',
                                          //   height: 80,
                                          //   width: 80,
                                          //   fit: BoxFit.cover,
                                          // )
                                  )
                                      : (listOfFile[index].contains(".doc"))
                                          ? Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: const DecorationImage(
                                                    image: NetworkImage(
                                                        'https://storage.googleapis.com/public_394582/plugins/doc_maker/logo.png'),
                                                    fit: BoxFit.cover,
                                                  )),
                                            )
                                          : Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: FileImage(File(
                                                        listOfFile[index])),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                  SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // color:Colors.pink,
                              child: IconButton(
                                  splashRadius: 2,
                                  onPressed: () {
                                    print('Cancel.....');
                                    setState(() {
                                      listOfFile.removeAt(index);
                                      fileList.removeAt(index);
                                    });
                                  },
                                  icon: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 0, bottom: 0),
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  )),
                            )
                          ],
                        );
                      })),

          // listOfFile.isEmpty? Container(): SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //
          //       ChoiceChipWidget(
          //         isShowCrossButton: true,
          //           dataList: listOfFile ,//dataList,
          //           //selectedColor:Colors.blue,
          //           tagClickCallBack: (item)
          //         {
          //           // Navigator.of(context).push(MaterialPageRoute(
          //           //     builder: (context) => FullPhotoView(
          //           //         profileImgUrl: '$item')));
          //         },
          //           onClickDelete: (index)
          //           {
          //          setState(() {
          //            //dataList.removeAt(index);
          //            listOfFile.removeAt(index);
          //          });
          //           },
          //       )
          //     ],
          //   ),
          // ),

          bottomButton(),
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
