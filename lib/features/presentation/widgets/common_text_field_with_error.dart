import 'package:workplace/imports.dart';

enum InputKeyboardTypeWithError {
  email,
  phone,
  text,
  password,
  number,
  multiLine
}

enum CapitalizationText {
  /// Defaults to an uppercase keyboard for the first letter of each word.
  ///
  /// Corresponds to `InputType.TYPE_TEXT_FLAG_CAP_WORDS` on Android, and
  /// `UITextAutocapitalizationTypeWords` on iOS.
  words,

  /// Defaults to an uppercase keyboard for the first letter of each sentence.
  ///
  /// Corresponds to `InputType.TYPE_TEXT_FLAG_CAP_SENTENCES` on Android, and
  /// `UITextAutocapitalizationTypeSentences` on iOS.
  sentences,

  /// Defaults to an uppercase keyboard for each character.
  ///
  /// Corresponds to `InputType.TYPE_TEXT_FLAG_CAP_CHARACTERS` on Android, and
  /// `UITextAutocapitalizationTypeAllCharacters` on iOS.
  characters,

  /// Defaults to a lowercase keyboard.
  none,
}

//enum TextInputActionType { none, unspecified, done, go, next, newline }

class CommonTextFieldWithError extends StatelessWidget {
  CommonTextFieldWithError(
      {this.controllerT,
      this.errorMsgHeight,
      this.maxLines = 1, //set maximum lines in text field
      this.maxCharLength = 50, // set maximum characters in text field
      this.inputHeight = 40, // set the height of a text field
      this.borderRadius = 0.5, // set border radius of text field
      this.hintText =
          'Enter some text...', // set place holder text in text field
      this.labelText = '', // set the label text in text field
      this.errorText = 'Please enter text', // set error text
      this.errorStyle, // set error text color
      this.enabledBorderColor =
          Colors.grey, // set enabled border color of a text field
      this.focusedBorderColor =
          Colors.grey, // set focused border color of a text field
      this.backgroundColor, // set background border color of a text field
      this.inputKeyboardType = InputKeyboardTypeWithError
          .text, // set keyboard type of a text field // 1 = emailAddress, 2 = phone and 3 = text
      this.labelStyle, // set text color of a text field
      this.textStyle, // set text color of a text field
      this.hintStyle, // set text color of a text field
      @required this.onTextChange, // set the onChange function call back
      @required this.onEndEditing, // set the onSubmitted function call back
      this.showError = false,
      this.autoFocus = false,
      this.focusNode,
      this.placeHolderEdgeInsets,
      this.focusedBorderWidth,
      this.inputFieldPrefixText,
      this.enabledBorderWidth,
      this.inputFieldSuffixIcon,
      this.inputFieldPrefixIcon,
      this.prefixSuffixIconSiz,
      this.cursorColor,
      this.placeHolderTextWidget,
      this.onTapCallBack,
      this.isTextFieldEnabled = true,
      this.readOnly = false,
      this.showCounterText = false,
      this.textAlignment,
      this.textAlignmentVertical,
      this.contentPadding,
      this.inputFormatter,
      this.obscureText = false,
      this.isShowBottomErrorMsg = false,
      this.errorMessages = "",
      this.errorMessageStyle,
      this.capitalization = CapitalizationText.sentences,
      this.errorLeftRightMargin = 12,
      this.textInputAction,
      this.lable,
      this.borderStyle,
      this.floatingLabelBehavior});

  final CapitalizationText capitalization;
  final bool showError;
  final bool autoFocus;
  final bool obscureText;
  final bool showCounterText;
  final double inputHeight;
  final double borderRadius;
  final int maxLines;
  final int maxCharLength;
  final double? focusedBorderWidth;
  final double? enabledBorderWidth;
  final double? errorMsgHeight;
  final String hintText;
  final String labelText;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final Color? cursorColor;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final InputKeyboardTypeWithError inputKeyboardType;
  final EdgeInsets? placeHolderEdgeInsets;
  final ValueChanged? onTextChange;
  final ValueChanged? onEndEditing;
  final FocusNode? focusNode;
  final TextEditingController? controllerT;
  final inputFieldSuffixIcon;
  final inputFieldPrefixIcon;
  final inputFieldPrefixText;
  final Size? prefixSuffixIconSiz;
  final Widget? placeHolderTextWidget;
  final GestureTapCallback? onTapCallBack;
  final bool isTextFieldEnabled;
  final bool readOnly;
  final TextAlign? textAlignment;
  final TextAlignVertical? textAlignmentVertical;
  final contentPadding;
  final inputFormatter;
  final TextInputAction? textInputAction;
  final bool isShowBottomErrorMsg;
  final String errorMessages;
  final TextStyle? errorMessageStyle;
  final double errorLeftRightMargin;
  final Widget? lable;
  final BorderStyle? borderStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;

//  get focusNode => null;
  @override
  Widget build(BuildContext context) {
//    Widget iconTemp(String imageUrl) {
//      return Container(
//        padding: EdgeInsets.all(10),
//        child: imageUrl != null
//            ? imageUrl.contains(".svg")
//                ? SvgPicture.asset(
//                    imageUrl,
//                    height: prefixSuffixIconSiz != null
//                        ? prefixSuffixIconSiz.height
//                        : 2,
//                    width: prefixSuffixIconSiz != null
//                        ? prefixSuffixIconSiz.width
//                        : 2,
//                    //fit: BoxFit.fill,
//                  )
//                : ImageIcon(
//                    new AssetImage(imageUrl),
//                  )
//            : Container(),
//      );
//    }

//    print('people icon $inputFieldSuffixIcon');

    TextCapitalization capitalizationTemp = TextCapitalization.sentences;
    switch (capitalization) {
      case CapitalizationText.characters:
        capitalizationTemp = TextCapitalization.sentences;
        break;
      case CapitalizationText.words:
        capitalizationTemp = TextCapitalization.words;
        break;
      case CapitalizationText.none:
        capitalizationTemp = TextCapitalization.none;
        break;
      case CapitalizationText.sentences:
        // TODO: Handle this case.
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: placeHolderEdgeInsets ??
              (placeHolderTextWidget != null
                  ? const EdgeInsets.fromLTRB(0, 0, 0, 5)
                  : const EdgeInsets.fromLTRB(0, 0, 0, 0)),
          child: placeHolderTextWidget,
        ),
        GestureDetector(
          onTap: onTapCallBack,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: inputHeight,
            decoration: BoxDecoration(
                color: Colors.transparent,
              boxShadow:  [
                BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 3,
                    offset: Offset(0, 1),
                    blurRadius: 3)
               ]
            ),
            child: Center(
              child: IgnorePointer(
                ignoring: !isTextFieldEnabled,
                child: TextField(
                  readOnly: readOnly,
                  autofocus: autoFocus,
                  maxLines: maxLines,
                  inputFormatters: inputFormatter ??
                      <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(maxCharLength),
                      ],
                  textInputAction: maxLines > 1
                      ? TextInputAction.newline
                      : (textInputAction == null ||
                              textInputAction == TextInputAction.done)
                          ? TextInputAction.done
                          : TextInputAction.next,
                  // textAlign: textAlignment ?? TextAlign.left,
                  // textAlignVertical: textAlignmentVertical == null
                  //     ? TextAlignVertical.center
                  //     : textAlignmentVertical,
                  controller: controllerT,
                  focusNode: focusNode,
                  enabled: isTextFieldEnabled,
                  onChanged: (value) {
                    if (value.length <= maxCharLength) {
                      //oldVal = value;
                      onTextChange!(value);
                    } else {
                      controllerT!.text = value.substring(0, maxCharLength);
                    }
                  },
                  cursorColor: cursorColor ?? AppColors.editCursorColor,
                  // ignore: unnecessary_null_comparison
                  onSubmitted: (maxCharLength != null)
                      ? (value) {
                          if (value.length <= maxCharLength) {
                            //oldVal = value;
                            onEndEditing!(value);
                          } else {
                            controllerT!.text =
                                value.substring(0, maxCharLength);
                          }
                        }
                      : onEndEditing,
                  style: textStyle,
                  obscureText:
                      obscureText /*??
                      inputKeyboardType ==
                          InputKeyboardTypeWithError.password*/
                  ,
                  buildCounter: (
                    BuildContext? context, {
                    int? currentLength,
                    int? maxLength,
                    bool? isFocused,
                  }) =>
                      showCounterText
                          ? Text(
                              '$currentLength/$maxCharLength',
                              style: AppStyle().counterTextStyle(
                                  texColor: const Color(0xFF575757),
                                  fontWeight: FontWeight.w300),
                              semanticsLabel: 'character count',
                            )
                          : null,
                  textCapitalization: capitalizationTemp,
                  decoration: InputDecoration(
                    //   prefixText: inputFieldPrefixText??'',
                    contentPadding: contentPadding ??
                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    suffixIcon: inputFieldSuffixIcon,
                    /*     suffixIcon:inputFieldSuffixIcon == null
                        ? null
                        : inputFieldSuffixIcon is IconData
                            ? Icon(inputFieldSuffixIcon)
                        : iconTemp(inputFieldSuffixIcon),*/
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                    prefixIcon: inputFieldPrefixIcon,
                    /*inputFieldPrefixIcon == null
                        ? null
                        : inputFieldPrefixIcon is IconData
                            ? Icon(inputFieldPrefixIcon)
                            : iconTemp(inputFieldPrefixIcon),*/
                    hintText: hintText,
                    hintStyle: hintStyle ??
                        const TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.transparent),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius),
                      ),
                      borderSide: BorderSide(
                        color: enabledBorderColor ?? Colors.grey,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(
                        color: enabledBorderColor ?? Colors.grey,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    labelText: labelText.isNotEmpty ? labelText : null,
                    label: lable,
                    labelStyle: labelStyle ??
                        const TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.transparent),
                    // errorText: showError ? (errorText != null)?errorText:errorText : null,
                    floatingLabelBehavior:
                        floatingLabelBehavior ?? FloatingLabelBehavior.always,
                    errorStyle: errorStyle ??
                        const TextStyle(
                            color: Colors
                                .white), //change by Mohit to red to white
                    fillColor: backgroundColor ?? Colors.transparent,
                    filled: true,
                    focusColor: Colors.blue,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius),
                      ),
                      borderSide: errorText == null
                          ? BorderSide(
                              color: enabledBorderColor!,
                              width: enabledBorderWidth ?? 1,
                              style: borderStyle ?? BorderStyle.solid,
                            )
                          : BorderSide(
                              color:
                                  enabledBorderColor!, //change by Mohit to red to white
                              width: enabledBorderWidth ?? 1,
                              style: borderStyle ?? BorderStyle.solid,
                            ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius),
                      ),
                      borderSide: errorText != null
                          ? BorderSide(
                              // ignore: unnecessary_null_comparison
                              color:
                                  enabledBorderColor!, //change by Mohit to red to white
                              width: focusedBorderWidth ?? 1.0,
                              style: borderStyle ?? BorderStyle.solid,
                            )
                          : BorderSide(
                              color: focusedBorderColor!,
                              width: focusedBorderWidth ?? 1.0,
                              style: BorderStyle.none,
                            ),
                    ),
                  ),
                  keyboardType: inputKeyboardType ==
                          InputKeyboardTypeWithError.email
                      ? TextInputType.emailAddress
                      : inputKeyboardType == InputKeyboardTypeWithError.phone
                          ? TextInputType.phone
                          : inputKeyboardType ==
                                  InputKeyboardTypeWithError.text
                              ? TextInputType.text
                              : inputKeyboardType ==
                                      InputKeyboardTypeWithError.number
                                  ? TextInputType.number
                                  : inputKeyboardType ==
                                          InputKeyboardTypeWithError.multiLine
                                      ? TextInputType.multiline
                                      : TextInputType.text,
                  maxLength: maxLines > 1 ? maxCharLength : maxCharLength,
                  // maxLengthEnforcement: MaxL,
                  // maxLengthEnforced: true,
                  /*style: TextStyle(
                    height: inputHeight,
                  ),*/
                ),
              ),
            ),
          ),
        ),
        !isShowBottomErrorMsg
            ? Container()
            : (errorMessages != '')
                ? Container(
                    margin: EdgeInsets.only(
                        right: errorLeftRightMargin * 2,
                        left: errorLeftRightMargin * 2),
                    height: errorMsgHeight ?? 24,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0, left: 10),
                      child: Text(
                        errorMessages,
                        style: errorMessageStyle ?? appStyles.errorStyle(),
                      ),
                    ))
                : Container(
                    height: errorMsgHeight ?? 24,
                  ),
      ],
    );
  }
}
