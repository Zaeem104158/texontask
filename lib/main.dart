import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:texontask/utils/style.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:texontask/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //old package name: com.nypd.columbia

    return GetMaterialApp(
      title: 'Friends',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        hintColor: colorDarkBlueMaterial,
        primarySwatch: colorDarkBlueMaterial,
        unselectedWidgetColor: kDisabledTextColor,
        appBarTheme: const AppBarTheme(
          elevation: 1,
          iconTheme: IconThemeData(
            color: colorDarkBlueMaterial,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
