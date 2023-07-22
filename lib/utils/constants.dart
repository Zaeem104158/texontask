import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:texontask/utils/style.dart';

import '../components/button_component.dart';
import '../components/text_component.dart';

typedef ResponseCallback<R, E> = void Function(R response, E error);

const sendTransition = Transition.rightToLeft;
const backTransition = Transition.leftToRight;
const sendSplashTransition = Transition.noTransition;

Timer? debouncer;

Future<void> debounceConst(VoidCallback voidCallback,
    {Duration duration = const Duration(milliseconds: 1000)}) async {
  if (debouncer != null) {
    debouncer!.cancel();
  }

  debouncer = Timer(duration, voidCallback);
}

void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void debounce(VoidCallback voidCallback,
    {Duration duration = const Duration(milliseconds: 1000)}) {
  if (debouncer != null) {
    debouncer!.cancel();
  }

  debouncer = Timer(duration, voidCallback);
}

Future<bool> isInternetConnected(BuildContext context,
    {bool isShowAlert = false}) async {
  bool isConnected = false;

  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    }
  } catch (_) {}

  if (isShowAlert && !isConnected) {
    showMessage("Internet Connectivity Problem");
  }

  return isConnected;
}

void loading({var value = "Please wait...", bool isHideKeyboard = true}) {
  if (isHideKeyboard) closeSoftKeyBoard();
  EasyLoading.show(status: value);
}

void dismissLoading() {
  EasyLoading.dismiss();
}

void showMessage(String? value, {bool isToast = false, bool isInfo = false}) {
  if (isInfo) {
    EasyLoading.showInfo("$value");
  } else if (isToast) {
    EasyLoading.showSuccess("$value");
  } else {
    dismissLoading();
    EasyLoading.showError("$value",
        duration: const Duration(seconds: 5), dismissOnTap: true);
  }
}

void showAlertDialog(String title, String body, String confirmButtonText,
    String cancelButtonText, Function(bool onConfirm, bool onCancel) clickEvent,
    {barrierDismissible = true}) {
  Get.defaultDialog(
    title: title,
    textConfirm: " $confirmButtonText ",
    textCancel: cancelButtonText,
    radius: 11,
    barrierDismissible: barrierDismissible,
    content: Text(
      body,
      textAlign: TextAlign.center,
    ),
    confirmTextColor: Colors.white,
    buttonColor: kPrimaryColor,
    cancelTextColor: kPrimaryColor,
    titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    contentPadding: const EdgeInsets.all(16),
    onConfirm: () {
      Get.back();
      clickEvent(true, false);
    },
    onCancel: () {
      Get.back();
      clickEvent(false, true);
    },
  );
}

void customAlertDialog(
    String body,
    String? confirmButtonText,
    String? cancelButtonText,
    Function(bool onConfirm, bool onCancel) clickEvent,
    {barrierDismissible = false}) {
  Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextComponent(
            body,
            textAlign: TextAlign.center,
            fontSize: textSmallFontSize,
            fontWeight: titleFontWeight,
            color: Colors.white,
          ),
          Row(
            //crossAxisAlignment : CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ButtonComponent(
                  text: cancelButtonText,
                  borderColor: kPrimaryColor,
                  onPressed: () {
                    Get.back();
                    clickEvent(false, true);
                  },
                  textColor: kPrimaryColor,
                  padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: ButtonComponent(
                  text: confirmButtonText,
                  buttonColor: kPrimaryColor,
                  onPressed: () {
                    Get.back();
                    clickEvent(true, false);
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                ),
              ),
            ],
          )
        ],
      ),
      barrierColor: Colors.white.withOpacity(0.8),
      useSafeArea: true);
}
