import 'package:intl/intl.dart';
import '../../../imports.dart';

class AddFamilyMember extends StatefulWidget {
  final String appbarTitle;
  final int? familyId;
  final String? name;
  final String? dob;
  final String? relation;
  final String? photo;
  final String? filename;
  const AddFamilyMember({Key? key,this.appbarTitle = AppString.addFamily, this.familyId,this.name ,this.dob, this.relation,  this.photo, this.filename
  }) : super(key: key);

  @override
  State<AddFamilyMember> createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {
  OverlayEntry? overlayEntry;
  DateTime? dateSingle ;
  String dateErrorMessage = "";
  String selectedRelationName = "";
  String relationErrorMessage = "";


  Map<String, TextEditingController> controllers = {
    'fullName':TextEditingController(
    ),
  };
  Map<String,FocusNode> focusNode = {
    'fullName' : FocusNode(),
  };
  Map<String, String> errorMessage={
    'fullName':"",
  };
  String? selectProfilePhotoPath;
  File? selectProfilePhoto;
  Map<String, File>? imageFile;
  Map<String, String>? imagePath;
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
                  // imageSelected = true;
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
                // imageSelected = true;
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

 Widget profilePhoto()
  {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.buttonBgColor4.withOpacity(0.5),
            ),
            child: CircularImage(
              height: 85,
              width: 85,
              image: selectProfilePhotoPath ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"
                  "",
              name: "",
              isClickToFullView: true,
            ),
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
    ],
  );}
  
  fullName() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
      width: MediaQuery.of(context).size.width,
      child: CommonTextFieldWithError(
        focusNode: focusNode['fullName'],
        isShowBottomErrorMsg: true,
         errorMessages: errorMessage['fullName']?.toString() ?? '',
         controllerT: controllers['fullName'],
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
        hintText: "Full Name",
        hintStyle: appStyles.textFieldTextStyle(
            fontWeight: FontWeight.w400,
            texColor: Colors.grey.shade600,
            fontSize: 14 ),
        textStyle: appStyles.textFieldTextStyle(fontWeight: FontWeight.w400),
        contentPadding:
        const EdgeInsets.only(left: 15, right: 15, top: -5, bottom: 0),
        onTextChange: (value) {
          checkFullName(value, 'fullName', onchange: true);
        },
        onEndEditing: (value) {
          checkFullName(value, 'fullName');
           FocusScope.of(context).requestFocus(focusNode['fullName']);
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> relationType= [
    const DropdownMenuItem(value: 'spouse',child: Text('Spouse'),),
    const DropdownMenuItem(value: 'son',child: Text('Son'),),
    const DropdownMenuItem(value: 'daughter',child: Text('Daughter'),),
    const DropdownMenuItem(value: 'mother',child: Text('Mother'),),
    const DropdownMenuItem(value: 'father',child: Text('Father'),),
    const DropdownMenuItem(value: 'other',child: Text('Other'),),
  ];

  relation() {
    return DropDownDataPicker(
      hint: 'Spouse',
      itemList: relationType,
      valueChoose:  widget.relation,
      selectedValue: (value) {
        setState(() {
          selectedRelationName = value;
          if (selectedRelationName.isEmpty) {
            relationErrorMessage = "";
          } else {
            relationErrorMessage = "";
          }
        });
      },
    );
  }

  Widget relationErrorText() => (relationErrorMessage != '')
      ? Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 25, top: 2),
      height: 18,
      child: Text(
        relationErrorMessage,
        style: appStyles.errorStyle(),
      ))
      : Container(height: 0.5);

  String singleDateText() {
    if (dateSingle == null) {
      return "Select DOB";
    } else {
      return DateFormat('dd/MM/yyyy').format(dateSingle!);
    }
  }

  void datePicker(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        fieldLabelText: "DOB",
        initialDate: dateSingle ?? DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(1900),
        //DateTime(DateTime.now().year),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month + 6, DateTime.now().day),
        // confirmText: "Ok",
        builder: (context, child) {
          return Theme(
              data: ThemeData().copyWith(
                // brightness:!isDarkMode? Brightness.light:Brightness.dark,
                  colorScheme: const ColorScheme.dark(
                      primary: AppColors.buttonBgColor4,
                      onSurface: Colors.black,
                      onPrimary: Colors.white,
                      surface: AppColors.white,
                      brightness: Brightness.light),
                  dialogBackgroundColor: AppColors.white),
              child: child!);
        });
    if (newDate == null) return;

    setState(() {
      dateSingle = newDate;
      if (dateSingle != null) {
        dateErrorMessage = "";
      }
    });
  }

  Widget dOBWidget() => Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(
                left: 12, right: 15, top: 5, bottom: 5),
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
            child: InkWell(
              onTap: () {
                datePicker(context);
              },
              child: Padding(
                padding:  const EdgeInsets.only(bottom: 6,top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WorkplaceIcons.iconImage(
                        imageUrl: WorkplaceIcons.calendarIcon,
                        imageColor: AppColors.grey,
                        iconSize: const Size(22, 22)),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(singleDateText().toString(),
                        style: appStyles.userJobTitleTextStyle(
                            fontSize: 14,
                            texColor:
                            dateSingle != null
                                ? Colors.black
                                : Colors.grey.shade600
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget dateErrorText() => ( dateErrorMessage != '')
      ? Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 25, top: 2),
      height: 18,
      child: Text(dateErrorMessage,
        style: appStyles.errorStyle(),
      ))
      : Container(height: 0.5);

  bottomButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: AppButton(
        buttonName: 'Submit',
        backCallback: () {
          if (validateFields(isButtonClicked: true)) {
                (widget.appbarTitle == AppString.editFamily )
                    ?
                BlocProvider.of<FamilyBloc>(context).add(UploadEditFamilyMediaEvent(
                imagePath: imagePath?.values.first ?? "",
                collectionName: 'photo', context: context,
                name: controllers['fullName']!.text.trim(),
                dob: dateSingle.toString().split(" ")[0],
                relation:  selectedRelationName.isEmpty ? widget.relation! : selectedRelationName,
                photo : widget.filename ?? "" ,
                familyId: widget.familyId ?? 0,
                )) :

                 BlocProvider.of<FamilyBloc>(context).add(UploadFamilyMediaEvent(
                     imagePath: imagePath?.values.first ?? "",
                     collectionName: 'photo',
                     context: context,
                     name: controllers['fullName']!.text.trim(),
                     dob: dateSingle.toString().split(" ")[0],
                     relation: selectedRelationName,
                     photo: imagePath?.values.first ?? "",
                 ));


          }
        },
      ),
    );
  }
  
  checkFullName(value, fieldEmail, {onchange = false}) {
    if (Validation.isNotEmpty(value.trim())) {
      setState(() {
        if (Validation.isNotEmpty(value.trim())) {
          errorMessage[fieldEmail] = "";
        } else {
          if (!onchange) {
            errorMessage[fieldEmail] =
                AppString.trans(context, AppString.emailHintError1);
          }
        }
      });
    } else {
      setState(() {
        if (!onchange) {
          if (fieldEmail == 'fullName') {
            errorMessage[fieldEmail] =
                AppString.trans(context, AppString.emailHintError);
          }
        }
      });
    }
  }

  bool validateFields({isButtonClicked = false})
  {
    if (controllers['fullName']?.text == null ||
        controllers['fullName']?.text == '') {
      setState(() {
        if (isButtonClicked) {
          FocusScope.of(context).requestFocus(focusNode['fullName']);
          errorMessage['fullName'] = 'Please enter full name';
        }
      });
      return false;
    } else if (!Validation.isNotEmpty(controllers['fullName']?.text ?? '')) {
      setState(() {
        if (isButtonClicked) {
          FocusScope.of(context).requestFocus(focusNode['fullName']);
          errorMessage['fullName'] =
              AppString.trans(context, 'Please enter full name');
        }
      });
      return false;
    }
    else if (widget.appbarTitle ==  AppString.editFamily ?  widget.relation!.isEmpty : selectedRelationName.isEmpty ) {
         if (isButtonClicked) {
           setState(() {
             relationErrorMessage = "Please Select relation";
           });
         }
         return false;
    } else if (dateSingle == null) {
      if (isButtonClicked) {
        setState(() {
          dateErrorMessage = "Please select the DOB";
        });
      }
      return false;
    }
    else
      {
        return true;
      }
  }

  @override
  void initState() {
    String date = widget.dob ?? "2024-05-06" ;
    DateTime dt = DateFormat('yyyy-MM-dd').parse(date);
    dateSingle  = widget.appbarTitle == AppString.editFamily ? dt: null;
    controllers['fullName']?.text = (widget.appbarTitle == AppString.editFamily ? widget.name: "")!;
    selectProfilePhotoPath = widget.appbarTitle == AppString.editFamily ? widget.photo :null;

    focusNode['fullName']!.addListener(() {
      if (Platform.isIOS || Platform.isAndroid) {
        bool hasFocus = focusNode['fullName']!.hasFocus;
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

    FamilyBloc bloc =  BlocProvider.of<FamilyBloc>(context);

    return ContainerFirst(
      contextCurrentView: context,
      appBarHeight: 50,
      appBar:  CommonAppBar(
        title: widget.appbarTitle,
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: BlocConsumer<FamilyBloc, FamilyState>(
        bloc: bloc,
        listener: (context, state) {
          if(state is AddFamilyMemberState)
          {
            Navigator.pop(context,true);
            Fluttertoast.showToast(
                backgroundColor: Colors.green.shade500,
                msg: AppString.memberAdded);
          }
          if(state is EditFamilyMemberState)
          {
            Navigator.pop(context,true);
            Fluttertoast.showToast(
                backgroundColor: Colors.green.shade500,
                msg: AppString.memberEdited);
          }
        },
        builder: (context, state)
        {
          if(state is familyErrorState)
          {
            return Center(
              child: Text(state.errorMessage ,style: const TextStyle(color: Colors.black),),
            );
          }
          return Stack(
            children: [
              Container(
                color: Colors.grey.shade50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    profilePhoto(),
                    const SizedBox(height: 20,),
                    const Padding(
                      padding: EdgeInsets.only(left: 18,bottom: 5),
                      child: Text('Full Name',style: TextStyle(color: Colors.black,fontSize: 14),),
                    ),
                    fullName(),
                    const SizedBox(height: 4,),
                    const Padding(
                      padding: EdgeInsets.only(left: 18,bottom: 5),
                      child: Text('Relation',style: TextStyle(color: Colors.black,fontSize: 14),),
                    ),
                    relation(),
                    relationErrorText(),
                    const SizedBox(height: 18,),
                    const Padding(
                      padding: EdgeInsets.only(left: 18,bottom: 5),
                      child: Text('Date Of Birth',style: TextStyle(color: Colors.black,fontSize: 14),),
                    ),
                    dOBWidget(),
                    dateErrorText(),
                    bottomButton(),
                  ],
                ),
              ),
              if(state is FamilyLoadingState) WorkplaceWidgets.progressLoader(context),
            ],
          );
        },
      ),
    );
  }




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
