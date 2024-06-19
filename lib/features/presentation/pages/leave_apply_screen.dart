import 'package:intl/intl.dart';
import 'package:workplace/imports.dart';

class LeaveApplyScreen extends StatefulWidget {
  final String appbarTitle;
  //final int? provisionalDifference;
  final bool? isUserEnableLeaveApply;
  List<LeaveTypeData>? leaveTypeData;

  LeaveApplyScreen(
      {Key? key, this.appbarTitle = AppString.leaveRequest, this.leaveTypeData, this.isUserEnableLeaveApply,
      //  this.provisionalDifference
      })
      : super(key: key);

  @override
  _LeaveApplyScreenState createState() => _LeaveApplyScreenState();
}

class _LeaveApplyScreenState extends State<LeaveApplyScreen> {
  late LeaveBloc leaveBloc;
  DateTime? dateStart;
  DateTime? dateEnd;
  DateTime? dateSingle;
  OverlayEntry? overlayEntry;

  List<DropdownMenuItem<String>> leaveTypes = [];

  Map<String, TextEditingController> controllers = {
    'reason': TextEditingController(),
  };

  Map<String, FocusNode> focusNodes = {
    'reason': FocusNode(),
  };

  Map<String, String> errorMessages = {
    'reason': "",
  };
String dob = " ";
  @override
  void initState() {
    leaveBloc = BlocProvider.of<LeaveBloc>(context);
    PrefUtils().readStr( WorkplaceNotificationConst.userDob).then((value) {
      setState(() {
        dob = value;
      });
    });
    focusNodes['reason']!.addListener(() {
      if (Platform.isIOS || Platform.isAndroid) {
        bool hasFocus = focusNodes['reason']!.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      }
    });

    leaveTypes = List.generate(
        widget.leaveTypeData!.length,
        (index) => DropdownMenuItem(
            value:
                '${widget.leaveTypeData![index].id}|${widget.leaveTypeData![index].availableLeave}',
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('${widget.leaveTypeData![index].name}'),
                Text(
                  ' (${widget.leaveTypeData![index].availableLeave})',
                  style: const TextStyle(color: AppColors.appAmber),
                ),
              ],
            )));

    selectedIndex = widget.appbarTitle == AppString.birthdayLeave?1 :0;
    super.initState();
  }

  @override
  void dispose() {
    controllers['reason']?.dispose();
    super.dispose();
  }


  String selectLeaveType = '';
  double selectedLeaveCount = 0.0;


  String formatDates(String inputString) {
    if (inputString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(inputString);

      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedDate;
    } else {
      return inputString;
    }
  }
  String startDateText() {
    if (dateStart == null) {
      return "Start Date";
    } else {
      return DateFormat('dd/MM/yyyy').format(dateStart!);
    }
  }

  String endDateText() {
    if (dateEnd == null && dateStart == null) {
      return "End Date";
    } else {
      return DateFormat('dd/MM/yyyy')
          .format(dateEnd == null ? dateStart! : dateEnd!);
    }
  }

  String singleDateText() {
    if (dateSingle == null) {
      return "Select Date";
    } else {
      return DateFormat('dd/MM/yyyy').format(dateSingle!);
    }
  }

  void startDate(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        selectableDayPredicate: (DateTime date) {
          if (date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday) {
            return false;
          }
          return true;
        },
        fieldLabelText: "DOB",
        initialDate: dateStart ?? DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime.now(),
        //DateTime(DateTime.now().year),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month + 12, DateTime.now().day),
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
      dateStart = newDate;
      if (dateStart != null) {
        startDateErrorMessage = "";
      }
    });
  }

  void endDate(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        selectableDayPredicate: (DateTime date) {
          if (date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday) {
            return false;
          }
          return true;
        },
        fieldLabelText: "DOB",
        initialDate: dateEnd == null ? dateStart! : dateEnd!,
        currentDate: dateStart,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: dateStart!,
        //DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month + 12, dateStart!.day),
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

    setState(() => dateEnd = newDate);
  }

  void singleDate(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        selectableDayPredicate: (DateTime date) {
          if (date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday) {
            return false;
          }
          return true;
        },
        fieldLabelText: "DOB",
        initialDate: dateSingle ?? DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month + 12, DateTime.now().day),
        builder: (context, child) {
          return Theme(
              data: ThemeData().copyWith(
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

  int selectedIndex = 0;
  String leaveTypeErrorMessage = '';
  String startDateErrorMessage = '';
  String dateErrorMessage = '';
  String leaveDayErrorMessage = '';
  String selectFullMultipleDay = '';
  String selectFirstSecondHalfDay = '';

  @override
  Widget build(BuildContext context) {
    AppDimens appDimens = AppDimens();
    appDimens.appDimensFind(context: context);
    checkReason(value, fieldEmail, {onchange = false}) {
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
            if (fieldEmail == 'reason') {
              errorMessages[fieldEmail] =
                  AppString.trans(context, AppString.emailHintError);
            }
          }
        });
      }
    }

    //Validate fields
    bool validateFields({isButtonClicked = false}) {
      if (selectLeaveType.isEmpty) {
        if (isButtonClicked) {
          setState(() {
            leaveTypeErrorMessage = "Please Select Leave type";
          });
        }
        return false;
      } else if (dayType[selectedIndex].typeName == "Day's"
          ? selectFullMultipleDay.isEmpty
          : selectFirstSecondHalfDay.isEmpty) {
        if (isButtonClicked) {
          setState(() {
            leaveDayErrorMessage = "Please select Leave Days";
          });
        }
        return false;
      } else if (selectFullMultipleDay == "multiple"
          ? dateStart == null
          : dateSingle == null) {
        if (isButtonClicked) {
          setState(() {
            startDateErrorMessage = "Please select Start Date";
            dateErrorMessage = "Please select the date";
          });
        }
        return false;
      } else if (controllers['reason']?.text == null ||
          controllers['reason']?.text == '') {
        setState(() {
          if (isButtonClicked) {
            FocusScope.of(context).requestFocus(focusNodes['reason']);
            errorMessages['reason'] = 'Please enter reason';
          }
        });
        return false;
      } else if (!Validation.isNotEmpty(controllers['reason']?.text ?? '')) {
        setState(() {
          if (isButtonClicked) {
            FocusScope.of(context).requestFocus(focusNodes['reason']);
            errorMessages['reason'] =
                AppString.trans(context, AppString.enterValidAddress);
          }
        });
        return false;
      } else {
        return true;
      }
    }

    //Validate fields
    bool validateWFHField({isButtonClicked = false}) {
      if (selectFirstSecondHalfDay.isEmpty) {
        if (isButtonClicked) {
          setState(() {
            leaveDayErrorMessage = "Please select Leave type";
          });
        }
        return false;
      } else {
        return true;
      }
    }

    bottomButton() {
      return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child:
        widget.appbarTitle == "Birthday Leave"
            ? AppButton(
                buttonName: "Submit Request",
                backCallback: () {
                  if (validateWFHField(isButtonClicked: true)) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        backgroundColor: Colors.green.shade500,
                        msg:  AppString.applicationSubmittedSuccessfully);
                  }
                },
              )
            :
        AppButton(
                buttonName: "Submit Request",
                backCallback: () {
                  if (validateFields(isButtonClicked: true)) {
                    leaveBloc.add(SubmitLeaveRequestEvent(
                      mContext: context,
                      leaveTypeID: int.parse(selectLeaveType),
                      reason: controllers['reason']!.text.trim(),
                      duration: dayType[selectedIndex].typeName == "Day's"
                          ? selectFullMultipleDay
                          : selectFirstSecondHalfDay,
                      startDate: selectFullMultipleDay == "multiple"
                          ? dateStart.toString().split(" ")[0]
                          : dateSingle.toString().split(" ")[0],
                      endDate: dateEnd.toString().split(" ")[0] == "null"
                          ? ""
                          : dateEnd.toString().split(" ")[0],
                    ));
                  }
                },
              ),
      );
    }

    // Country dropdown widget
    Widget leaveTypeField() => DropDownDataPicker(
          hint: 'Leave Type',
          borderColor:
              leaveTypeErrorMessage != '' ? Colors.red : Colors.transparent,
          itemList: leaveTypes,
          selectedValue: (value) {
            setState(() {

              selectLeaveType = value.toString().split('|').first;
              selectedLeaveCount =
                  double.tryParse(value.toString().split('|')[1]) ?? 0;

              if (selectLeaveType.isEmpty) {
                leaveTypeErrorMessage = "";
              } else {
                leaveTypeErrorMessage = "";
              }
            });
          },
        );
    Widget leaveErrorText = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          (leaveTypeErrorMessage != '')
              ? Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25, top: 2),
                  height: 18,
                  child: Text(
                    leaveTypeErrorMessage,
                    style: appStyles.errorStyle(),
                  ))
              : Container(height: 0.5),
          const Spacer(),
          (selectedLeaveCount!=0.0)? Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 25, top: 2),
              height: 18,
              child: Text(
                "Available leaves - $selectedLeaveCount",
                style: (selectedLeaveCount == 0)
                    ? appStyles.errorStyle()
                    : appStyles.titleStyle().copyWith(fontSize: 10),
              )):const SizedBox()
        ],
      ),
    );

    Widget fullMultipleField() => DropDownDataPicker(
          borderColor:
              leaveDayErrorMessage != '' ? Colors.red : Colors.transparent,
          hint: 'Single Day',
          itemList: const [
            DropdownMenuItem(
              value: 'full_day',
              child: Text('Single Day'),
            ),
            DropdownMenuItem(
              value: 'multiple',
              child: Text('Multiple Days'),
            ),
          ],
          selectedValue: (value) {
            setState(() {
              selectFullMultipleDay = value;
              if (selectFullMultipleDay.isEmpty) {
                leaveDayErrorMessage = "";
              } else {
                leaveDayErrorMessage = "";
              }
            });
          },
        );

    Widget firstSecondHalfField() => DropDownDataPicker2(
          borderColor: leaveDayErrorMessage != '' ? Colors.red : Colors.transparent,
          hint:  widget.appbarTitle == AppString.birthdayLeave ?'Second Half':'First Half',
          itemList:  [
            if(widget.appbarTitle != AppString.birthdayLeave )   const DropdownMenuItem(
              value: 'first_half',
              child: Text('First Half'),
            ),
            const DropdownMenuItem(
              value: 'second_half',
              child: Text('Second Half'),
            )
          ],
          selectedValue: (value) {
            setState(() {
                selectFirstSecondHalfDay = value;
              if (selectFirstSecondHalfDay.isEmpty) {
                leaveDayErrorMessage = "";
              } else {
                leaveDayErrorMessage = "";
              }
            });
          },
        );
    Widget leaveDayErrorText() => (leaveDayErrorMessage != '')
        ? Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 25, top: 2),
            height: 18,
            child: Text(
              leaveDayErrorMessage,
              style: appStyles.errorStyle(),
            ))
        : Container(height: 0.5);

    Widget date() => Padding(
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
                      border: Border.all(
                        width: 1,
                        color: startDateErrorMessage != ''
                            ? Colors.red
                            : Colors.transparent,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 3,
                            offset: const Offset(0, 1),
                            blurRadius: 3)
                      ]),
                  child: InkWell(
                    onTap: () {
                      startDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: WorkplaceIcons.iconImage(
                              imageUrl: WorkplaceIcons.calendarIcon,
                              imageColor: AppColors.grey,
                              iconSize: const Size(22, 22)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(startDateText().toString(),
                            style: appStyles.userJobTitleTextStyle(
                                fontSize: 14,
                                texColor: dateStart != null
                                    ? Colors.black
                                    : Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
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
                      if (dateStart != null) {
                        endDate(context);
                      } else {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.red.shade700,
                            msg: "Please select the start date first");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: WorkplaceIcons.iconImage(
                              imageUrl: WorkplaceIcons.calendarIcon,
                              imageColor: AppColors.grey,
                              iconSize: const Size(22, 22)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(endDateText().toString(),
                            style: appStyles.userJobTitleTextStyle(
                                fontSize: 14,
                                texColor: dateEnd != null || dateStart != null
                                    ? Colors.black
                                    : Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    Widget starDateErrorText = (dayType[selectedIndex].typeName == "Full-Day"
            ? startDateErrorMessage != ''
            : dateErrorMessage != '')
        ? Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 25, top: 2),
            height: 18,
            child: Text(
              dayType[selectedIndex].typeName == "Full-Day"
                  ? startDateErrorMessage
                  : dateErrorMessage,
              style: appStyles.errorStyle(),
            ))
        : Container(height: 0.5);

    Widget singleDateWidget() => Padding(
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
                      if(widget.appbarTitle != "Birthday Leave") {
                        singleDate(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: WorkplaceIcons.iconImage(
                              imageUrl: WorkplaceIcons.calendarIcon,
                              imageColor: AppColors.grey,
                              iconSize: const Size(22, 22)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text( widget.appbarTitle == "Birthday Leave"? formatDates(dob) : singleDateText().toString(),
                            style: appStyles.userJobTitleTextStyle(
                                fontSize: 14,
                                texColor: dateSingle != null
                                    ? Colors.black
                                    : Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

     reasonField() {return Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
        width: MediaQuery.of(context).size.width,
        child: CommonTextFieldWithError(
          focusNode: focusNodes['reason'],
          isShowBottomErrorMsg: true,
          errorMessages: errorMessages['reason']?.toString() ?? '',
          controllerT: controllers['reason'],
          borderRadius: 8,
          inputHeight: 100,
          errorLeftRightMargin: 0,
          maxCharLength: 1200,
          errorMsgHeight: 18,
          maxLines: 5,
          autoFocus: false,
          showError: true,
          showCounterText: false,
          capitalization: CapitalizationText.sentences,
          cursorColor: Colors.grey,
          enabledBorderColor: Colors.white,
          focusedBorderColor: Colors.white,
          backgroundColor: AppColors.white,
          textInputAction: TextInputAction.newline,
          borderStyle: BorderStyle.solid,
          inputKeyboardType: InputKeyboardTypeWithError.multiLine,
          hintText: "Reason * ",
          // lable: Padding(
          //   padding: const EdgeInsets.only(
          //     top: 20,
          //   ),
          //   child: RichText(
          //       text: const TextSpan(
          //           text: 'Reason ',
          //           style: TextStyle(color: Colors.grey, fontSize: 18),
          //           children: [
          //         TextSpan(
          //             text: '*',
          //             style: TextStyle(
          //               color: Colors.red,
          //             ))
          //       ])),
          // ),
          hintStyle: appStyles.textFieldTextStyle(
              fontWeight: FontWeight.w400,
              texColor: Colors.grey.shade600,
              fontSize: 14),
          textStyle: appStyles.textFieldTextStyle(fontWeight: FontWeight.w400),
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          onTextChange: (value) {
            checkReason(value, 'reason', onchange: true);
          },
          onEndEditing: (value) {
            checkReason(value, 'reason');
            FocusScope.of(context).requestFocus(focusNodes['password']);
          },
        ),
      );}

    fullHalfDayWidget() => Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: AppColors.buttonBgColor4)),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              scrollDirection: Axis.horizontal,
              itemCount: dayType.length,
              itemBuilder: (context, index) {
                return ChoiceChip(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 0, right: 0),
                  labelPadding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 0, right: 0),
                  elevation: 0,
                  pressElevation: 0,
                  label: Container(
                    width: appDimens.widthFullScreen() / 2.25,
                    alignment: Alignment.center,
                    child: Text(
                      dayType[index].typeName,// ${selectedLeaveCount!=0.0 ? selectedLeaveCount :""}",
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : AppColors.buttonBgColor4),
                    ),
                  ),
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: index == 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))
                        : const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                  ),
                  backgroundColor: Colors.transparent,
                  selectedColor: AppColors.buttonBgColor4,
                  selected: selectedIndex == index,
                  onSelected: (selected) {
                    if( widget.appbarTitle != "Birthday Leave") {
                      setState(() {
                      selectedIndex = index;
                    });
                    }
                  },
                );
              }),
        );

    return ContainerFirst(
      contextCurrentView: context,
      isSingleChildScrollViewNeed: true,
      appBarHeight: 50,
      appBar: CommonAppBar(
        title: widget.appbarTitle,
        icon: WorkplaceIcons.backArrow,
      ),
      containChild: BlocConsumer<LeaveBloc, LeaveState>(
        bloc: leaveBloc,
        listener: (context, state) {
          if (state is LeaveAppliedState) {
            Navigator.pop(context, true);
            Fluttertoast.showToast(
                backgroundColor: Colors.green.shade500,
                msg: AppString.applicationSubmittedSuccessfully);
          }
        },
        builder: (context, state) {
          return
            //(widget.provisionalDifference! > 3)
            ( widget.isUserEnableLeaveApply == true)
              ? Container(
            color: Colors.grey.shade50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                widget.appbarTitle == AppString.birthdayLeave ? Container() : leaveTypeField(),
                widget.appbarTitle == AppString.birthdayLeave ? Container() : leaveErrorText,
                const SizedBox(height: 20,),
                fullHalfDayWidget(),
                const SizedBox(height: 20,),
                dayType[selectedIndex].typeName == "Day's" ? fullMultipleField() : firstSecondHalfField(),
                leaveDayErrorText(),
                const SizedBox(
                  height: 20,
                ),
                widget.appbarTitle == AppString.birthdayLeave? const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Date',style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ):Container(),
                const SizedBox(height: 5,),
                dayType[selectedIndex].typeName == "Day's"
                    ? selectFullMultipleDay == 'multiple'
                        ? date()
                        : singleDateWidget()
                    : singleDateWidget(),
                starDateErrorText,
                widget.appbarTitle == AppString.birthdayLeave? SizedBox(): const SizedBox(
                  height: 20,
                ),
                widget.appbarTitle == AppString.birthdayLeave
                    ? const SizedBox() : reasonField(),
                const SizedBox(
                  height: 5,
                ),
                bottomButton()
              ],
            ),
          ) :
          Padding(
            padding: EdgeInsets.only(left: 15.sp,right: 15.sp),
            child: Center(
              child: Text('You are not eligible to apply Leave.',
                textAlign: TextAlign.center,
                style: appStyles.noDataTextStyle(),
              ),
            ),
          )
          ;
        },
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(item,
            style: appStyles.userNameTextStyle(
                fontSize: 13.5, fontWeight: FontWeight.w500)));
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
