import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:texontask/utils/style.dart';
import '../utils/constants.dart';
import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    isInternetConnected(context).then((internet) {
      if (internet) {
        // Internet Present Case
        Get.offAll(() => const DashBoardScreen(), transition: sendTransition);
      } else {
        // No-Internet Case
        showWarningDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPreliminaryColor,
    );
  }

  showWarningDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text(
        "Retry",
      ),
      onPressed: () {
        Navigator.pop(context);
        EasyLoading.showToast("Please wait...");

        isInternetConnected(context).then((internet) {
          if (internet) {
            // Internet Present Case
            Get.offAll(() => const DashBoardScreen(),
                transition: sendTransition);
          } else {
            // No-Internet Case
            showWarningDialog(context);
          }
        });
      },
    );

    Widget cancelButton = TextButton(
      child: const Text(
        "Exit",
      ),
      onPressed: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    );

    if (Platform.isIOS) {
      CupertinoAlertDialog alert = CupertinoAlertDialog(
        title: const Text(
          "No Internet connection!",
        ),
        content: const Text(
          "Please Connect your device to internet first",
        ),
        actions: [cancelButton, continueButton],
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      AlertDialog alert = AlertDialog(
        elevation: 2,
        title: const Text(
          "No Internet connection!",
        ),
        content: const Text(
          "Please Connect your device to internet first",
        ),
        actions: [cancelButton, continueButton],
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
