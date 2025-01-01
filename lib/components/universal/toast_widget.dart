import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as l;
import 'package:toastification/toastification.dart';




class AppStrings {
  static const password =
      'Your password recovery mail has been sent to email address, please go to your mail and confirm and recover your password';
  static const String appName = "Storri";
  static const String versionType = "beta version";

  static const String CACHE_INTEREST = "CACHE_INTEREST";
  static const String CACHE_AUTH_RESPONSE = "CACHE_AUTH_RESPONSE";
  static const String CACHE_VIDEO_KEYS = "CACHE_VIDEO_KEYS";
  static const String CACHED_USER = "CACHED_USER";
  static const String FRESH_INSTALL = "FRESH_INSTALL";
  static const String NEW_INSTALL = "NEW_INSTALL";
  static const String LOGGED_OUT = "LOGGED_OUT";
  static const String CREATOR_LOGGED_OUT = "CREATOR_LOGGED_OUT";
  static const String LOGGED_IN = "LOGGED_IN";
  static const String CREATOR_LOGGED_IN = "CREATOR_LOGGED_IN";
  static const String PENDING_VERIFICATION = "PENDING_VERIFICATION";
  static const String TOKEN_EXPIRED = "TOKEN_EXPIRED";
  static const String CACHE_TOKEN = "CACHE_TOKEN";
  static const String CACHE_IS_TOKEN_EXPIRED = "CACHE_IS_TOKEN_EXPIRED";
  static const String CACHE_STATE = "CACHE_STATE";
  static const String AUTH_TYPE = "AUTH_TYPE";
  static const String CACHE_ANON_USER = "CACHE_ANON_USER";
  static const String IS_NEW_TO_COMMENTS = "IS_NEW_TO_COMMENTS";
  // Validation defaults
  static const emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const phonePattern = r'^[0][1-9]\d{9}$';
  static const otpPattern = r'^[1-9]\d{5}$';
  static const urlDetectorPattern =
      r'^((http|ftp|https):\/\/)?([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?';

  //custom text styles
  static const String bodyText = "bodyText";
  static const String bodyTextSmall = "bodyTextSmall";
  static const String headerText = "headerText";
  static const String buttonText = "buttonText";
  static const String largerText = "largerText";
  static const String largestText = "largestText";
  static const String productSans = "ProductSans";
  static const String oops = "Ooops..!";
  static const String error = 'error';
  static const String success = 'success';
  static const String noInternet = 'noInternet';
  //Strings used in the app...
  static const List<String> WeekNumber = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '20',
  ];
  static const List<String> displayPriority = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '20',
  ];
  static const List<String> contentType = ["Video", "Audio", "Document"];
  static const List<String> videoContentAllowedExtensions = ['mov', 'mp4'];
  static const List<String> audioContentAllowedExtensions = ['mp3'];
  static const List<String> documentsContentAllowedExtensions = [
    'jpg',
    'pdf',
    'doc',
    'docs'
  ];
  static const List<String> allContentAllowedExtensions = [
    'jpg',
    'pdf',
    'doc',
    'docs',
    'mp3',
    'mov',
    'mp4'
  ];

  //mocked Json array
  static const List<Map<String?, dynamic>> title = [
    {
      "title": "Python",
    },
    {
      "title": "Information",
    },
    {
      "title": "Java",
    },
    {
      "title": "Fashion",
    },
    {
      "title": "Excel",
    },
    {
      "title": "Robotics",
    },
    {
      "title": "Photography",
    },
    {
      "title": "Cuisines",
    },
    {
      "title": "Sql",
    },
    {
      "title": "Cooking",
    },
  ];

  // Api requests
  static const String userDetails = "user_details";
  static const String updateUserProfile = "update_profile";
  static const String retrieveUserProfile = "retrieve_profile";
  static const String verifyUserHandle = "verify_handle";
  static const String refreshToken = "user/refresh-token";
  static const String checkCode = "check_code";
  static const String checkLogin = "user/login";
  static const String activity = "activity";
  static const String checkUDid = "user/device/";
  static const String feeds = "videos?count=5";

  static const sampleImageUrl2 =
      "https://cdn3.vectorstock.com/i/1000x1000/74/57/ai-robot-flat-color-icon-vector-29147457.jpg";
  static const sampleImageUrl =
      "https://img.freepik.com/free-photo/front-view-stacked-books-graduation-cap-diploma-education-day_23-2149241011.jpg?w=2000";

}


void newErrorSnack(BuildContext context, String message) {
  toastification.show(
      context: context,
      title: Text("Error"),
      description: Text(message),
      backgroundColor: const Color(0xffde2a43),
      showProgressBar: false,
      primaryColor: Colors.white,
      foregroundColor: Colors.white,
      autoCloseDuration: const Duration(seconds: 3));
}

void newSuccessSnack(BuildContext context, String message) {
  toastification.show(
      context: context,
      title: Text("Successful"),
      description: Text(message),
      backgroundColor: Color.fromARGB(255, 52, 133, 56),
      showProgressBar: false,
      primaryColor: Colors.white,
      foregroundColor: Colors.white,
      autoCloseDuration: const Duration(seconds: 3));
}

void showLoader(BuildContext context) {
  l.Loader.show(context,
      progressIndicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.teal),
      ),
      overlayColor: Colors.grey.withOpacity(0.5));
}

void hideLoader() {
  l.Loader.hide();
}
