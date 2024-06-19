import 'package:flutter/material.dart';
import 'package:workplace/core/util/utils.dart';

abstract class AppString {
  static BuildContext? context;

  //appString.trans(context,appString.basicInfo);
  static String trans(BuildContext context, String key) {
    if (key != null && key.trim() != "" && context != null) {
      var data = AppLocalizations.of(context)?.translate(key);
      if (data == null) {
        return "";
      }
      return data;
    } else {
      return "";
    }
  }

  static const String selectCountry = '';
  static const String appName = 'Base Flutter App';
  static const String profileSetup = 'profileSetup';
  static const String showerBegins = 'showerBegins';
  static const String start = 'start';
  static const String continueBt = 'continue';
  static const String next = 'next';
  static const String createProfile = 'createProfile';
  static const String nextSmall = 'nextSmall';

  static const String editPhoto = 'editPhoto';
  static const String choose = 'choose';
  static const String addPhoto = 'addPhoto';

  static const String remove = 'remove';

  static const String pleaseEnterPassword = 'pleaseEnterPassword';
  static const String pleaseEnterCurrentPassword = 'pleaseEnterCurrentPassword';
  static const String pleaseReEnterPassword = 'pleaseReEnterPassword';
  static const String firstName = 'firstName';
  static const String name = 'name';
  static const String chooseAvatar = 'chooseAvatar';
  static const String age = 'age';
  static const String enterValidEmail = 'enterValidEmail';
  static const String enterAPassword = 'enterAPassword';
  static const String enterValidPassword = 'enterValidPassword';
  static const String enterFirstEmail = 'enterFirstEmail';
  static const String signUpEmail = 'signUpEmail';
  static const String welcome = 'welcome';
  static const String signInTitle = 'signInTitle';
  static const String verificationCodeTitle = 'verificationCodeTitle';
  static const String acceptTermsCondition1 = 'acceptTermsCondition1';
  static const String terms = 'terms';
  static const String and = 'and';
  static const String privacyPolicy = 'privacyPolicy';
  static const String pleaseEnterNewPassword = 'pleaseEnterNewPassword';
  static const String changePassword = 'changePassword';
  static const String newPassword = 'newPassword';
  static const String currentPassword = 'currentPassword';
  static const String confirm = 'confirm';

  static const String email = 'email';
  static const String swipeToStart = 'swipeToStart';
  static const String pleaseEnterEmail = 'pleaseEnterEmail';
  static const String loginT = 'login';
  static const String createAccountButton = 'createAccountButton';
  static const String newCode = 'newCode';
  static const String verify = 'verify';
  static const String lastName = 'lastName';
  static const String password = 'password';
  static const String verificationCode = 'verificationCode';
  static const String confirmPassword = 'confirmPassword';
  static const String enterFirstName = 'enterFirstName';
  static const String enterName = 'enterName';
  static const String enterLastName = 'enterLastName';
  static const String enterPassword = 'enterPassword';
  static const String enterVerificationCode = 'enterVerificationCode';
  static const String enterConfirmPassword = 'enterConfirmPassword';
  static const String howManyEmployees = 'howManyEmployees';
  static const String createPassword = 'createPassword';
  static const String mustContain1LetterAndNumber = 'mustContain1LetterAndNumber';
  static const String passwordContain ='The password must be at least 8 characters.';
  static const String completeSetUPButton = 'completeSetUPButton';
  static const String validName = 'validName';
  static const String signIn = 'signIn';
  static const String back = 'back';
  static const String signUpButton = 'signUpButton';
  static const String createAPassword = 'createAPassword';

  static const String send = 'send';
  static const String signOut = 'signOut';
  static const String aboutDrawer = 'aboutDrawer';
  static const String editProfile = 'editProfile';
  static const String passwordLength = 'passwordLength';
  static const String viewProfile = 'viewProfile';
  static const String titleText = 'titleText';
  static const String departmentText = 'departmentText';
  static const String save = 'save';

  static const String tryAgain = 'Something went wrong please try again';
  //Button text
  static const String buttonSave = "buttonSave";
  static const String buttonUpdate = "buttonUpdate";
  static const String buttonCancel = "Cancel";
  static const String buttonApply = "Apply";
  static const String buttonConfirm = "Confirm";
  static const String buttonGallery = "Media";
  static const String buttonCamera = "Photo";
  //Alert message
  static const String logoutConfirmation = "logoutConfirmation";

  static const String deletePostMessage = "Are you sure to delete this post?";
  static const String deleteGroupChannelMessage =
      "Are you sure to delete this Group Channel?";
  static const String leftGroupMessage = "Are you sure to left this group?";
  static const String noInternetConnection =
      "No internet connection available. Please check your network!";
  static const String noText = "No";
  static const String yesText = "Yes";

  static const String notificationHeading = 'notificationHeading';

  static const String general = 'general';

  //error messages
  static const String passwordNotBlank = 'Please enter the password.';
  static const String screenTermsAndConditions = "Terms and conditions";

  //Login screen static const Strings
  static const String contactText =
      "If you have problems to login, please get in contact at ";
  static const String acceptTermsAndConditions =
      'Check here to indicate that you have read and agree to the "';
  static const String termsAndConditions = 'terms of the main flutter app';

  static const String messageHeading = 'messageHeading';
  static const String messageScreenSubtitle1 = 'messageScreenSubtitle1';
  static const String chatBoxHintText = 'chatBoxHintText';

  //Contact email id
  static const String contactEmail = "dexbytes@gmail.com";

  static const String emailNotBlank = 'Please enter your number';
  static const String validEmail = 'Please enter a valid mobile number.';

  //confirmation message
  static const String confirmationMessage =
      "Are you sure you want to delete this notification?";
  static const String confirmationLogoutMessage =
      "Are you sure you want to sign out?";

  static const String confirmationChangePasswordOTPMessage =
      "It will send an OTP to your email, Do you want to change your password?";

  static const String confirmationChangeEmailOTPMessage =
      "It will send an OTP to your email, Do you want to change your email?";
  static const String confirmationExitMessage =
      "Are you sure you want to exit from the app?";
  static const String confirmationDeletePostMessage =
      "Are you sure you want to delete this post?";
  static const String confirmationDeleteGroupMessage =
      "Are you sure you want to delete this group?";
  static const String confirmationLeftGroupMessage =
      "Are you sure you want to leave this group?";

  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'hh:mm a';

  static const String logout = 'logout';

  static const String signUpText = "signUpText";
  static const String signUpWith = "signUpWith";
  static const String personalEmail = "personalEmail";
  static const String recommendedText = "recommendedText";
  static const String contactWillText = "contactWillText";
  static const String hintText = "hintText";
  static const String continueBtnT = "continueBtnT";
  static const String byTappingText = "byTappingText";
  static const String termsOfServices = "termsOfServices";
  static const String contactManagement = "contactManagement";
  static const String signUpToday = "signUpToday";
  static const String noPaymentRequired = "noPaymentRequired";
  static const String getStarted = "getStarted";
  static const String step1Of2 = "step1Of2";
  static const String secretCode = "secretCode";
  static const String codeExpires = "codeExpires";
  static const String junkFolder = "junkFolder";
  static const String resendCode = "resendCode";
  static const String resendCodeNew = "resendCodeNew";
  static const String needHelp = "needHelp";
  static const String contactUs = "contactUs";

  static const String step2Of2 = "step20f2";
  static const String enterYourName = "enterYourName";
  static const String headingFirstName = "First Name";
  static const String headingLastName = "Last Name";

  static const String howManyContactText = "howManyContactText";
  static const String firstBtnValue = "firstBtnValue";
  static const String secondBtnValue = "secondBtnValue";
  static const String thirdBtnValue = "thirdBtnValue";
  static const String swipeBtn = "swipeBtn";
  static const String stepText2Of2 = "stepText2Of2";
  static const String signInText = "signInText";
  static const String signInEmail = "signInEmail";
  static const String hiNickText = "hiNickText";
  static const String setUpYours = "setUpYours";
  static const String step1Of3 = "step1Of3";
  static const String importContact = "importContact";
  static const String skip = "skip";
  static const String nextBtn = "nextBtn";
  static const String didntReceiveCode = 'didntReceiveCode';
  static const String pleaseEnterOtp = "pleaseEnterOtp";
  static const String pleaseEnterCorrectOtp = "pleaseEnterCorrectOtp";
  static const String invalidName = 'invalidName';
  static const String enterFullName = "enterFullName";
  static const String phoneNumber = 'phoneNumber';
  static const String correctPhone = 'correctPhone';
  static const String enterValidAddress = "enterValidAddress";
  static const String enterReason = "enterReason";
  static const String enterCustomerId = "enterCustomerId";
  static const String emailHintError = "emailHintError";
  static const String emailHintError1 = "emailHintError1";
  static const String workEmail = "workEmail";
  static const String confirmPasswordName = "confirmPasswordName";
  static const String invalidCurrentPassword = "invalidCurrentPassword";
  static const String pleaseEnterNewCPassword = 'pleaseEnterNewCPassword';
  static const String passwordMustBeSame = "passwordMustBeSame";
  static const String pleaseReEnterConfirmPassword =
      'pleaseReEnterConfirmPassword';



  static const String deleteConfirmation = "deleteConfirmation";
  static const String deletePopupTitle = "deletePopupTitle";
  static const String deletePopupContent = "deletePopupContent";
  static const String upcomingBirthday = "Upcoming Birthday";
  static const String upcomingWorkAnniversary = "Upcoming Work Anniversaries";
  static const String upcomingMarriageAnniversary = "Upcoming Marriage Anniversaries";
  static const String upcomingHoliday = "Upcoming Holidays";
  static const String events = "Events";
  static const String noEvents ='No event';
  static const String announcements= "Announcements";
  static const String todayLeave= "On Leave Today";
  static const String whfLeave= "On WHF Today";
  static const String faq= "FAQ";
  static const String noFaq= "No faq";
  static const String birthdays= "Birthdays";
  static const String noBirthdays= "No birthday";
  static const String noUpcomingBirthdays= "No upcoming birthday";
  static const String event= "Events";
  static const String aboutUS= "About Us";
  static const String allTicket= "All Ticket";
  static const String announcement= "Announcement";
  static const String noAnnouncement=  'No Announcement';
  static const String somethingWentWrong=  'Something went wrong here...' ;
  static const String technicalIssue=  'Sorry we are having some technical issue.You may refresh the page or try again later';
  static const String noUpComingWA= 'No upcoming work anniversary';
  static const String addFamily= "Add Family Member Details";
  static const String editFamily= "Edit Family Member Details";
  static const String memberAdded= "Member Added successfully";
  static const String memberEdited= "Member Details edited successfully";
  static const String workAnniversary= 'Work Anniversaries';
  static const String noWorkAnniversary= 'No WorkAnniversary';
  static const String noWhf= 'No WHF on today';
  static const String noLeaveToday =  'No leave on today' ;
  static const String noDataFound = 'No data found';
  static const String ourTeam = 'Our Team';
  static const String passwordUpdated = 'Password updated successfully';
  static const String changePasswordTitle =  'Change Password';
  static const String ok = "OK";
  static const String posts = 'Posts';
  static const String noPosts = 'No Posts';
  static const String holidays = 'Holidays';
  static const String noHolidays = 'No Holiday';
  static const String  applicationSubmittedSuccessfully= "Application submitted successfully";
  static const String noUpcomingMA = 'No upcoming marriage anniversary';
  static const String  marriageAnniversaries = 'Marriage Anniversaries';
  static const String  noMarriageAnniversary = 'No MarriageAnniversary';
  static const String notifications = "Notifications";
  static const String noNotifications = 'No notifications';
  static const String settings = "Settings";
  static const String hurryFullPresent= 'Hurry! Full Present';
  static const String leaveWHF = 'Leave/WHF';
  static const String myLeave = 'My Leave';
  static const String leaveRequests= "Leave Request's ";
  static const String leaveRequest= "Leave Request";
  static const String leaveDetails= "Leave Detail";
  static const String noLeaveDetails= 'No Leave Detail';
  static const String noLeaveRequest= 'No Leave Request';
  static const String history = 'History';
  static const String birthdayLeave = "Birthday Leave" ;
  static const String applyLeave = "Apply Leave" ;
  static const String requestConfirmation = 'Request Confirmation';
  static const String requestConfirmationContent = 'Are you sure you want to accept the leave request?';
  static const String rejectConfirmation = 'Reject Confirmation';
  static const String rejectConfirmationContent = 'Are you sure you want to reject the leave request?';
  static const String cancelLeave='Cancel Leave';
  static const String cancelLeaveContent ='Are your sure you want to cancel your leave?';
  static const String reject = 'Reject';
  static const String cancel= 'Cancel';
  static const String accept = 'Accept';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String leaveType = "Leave Type";
  static const String duration = "Duration";
  static const String totalLeaveDays = "Total Leave Days";
  static const String reason = "Reason";
  static const String lessDetails = 'Less Details';
  static const String moreDetails = 'More Details';
  static const String gitBucketUserName = "Gitbucket Username";
  static const String githubUsername =  "Github Username";
  static const String skype = "Skype";
  static const String marriageAnniversary =  "Marriage Anniversary ";
  static const String dob = "Date Of Birth";
  static const String alternatePhone = "Alternate phone";
  static const String alternateAddress = "Alternate Address";
  static const String address =  "Address";
  static const String skills = "Skills";
  static const String doj = "Date Of Joining";
  static const String phone = "Phone";
  static const String post = "Post";
  static const String noPost = 'No Post';
  static const String manageFamily = "Manage Family";
  static const String familyDetailsNotAvailable = "Family details not available";
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String readMore = 'read more';
  static const String readLess = 'read less';


}
