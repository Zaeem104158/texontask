import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/text_component.dart';
import '../controller/user_controller.dart';
import '../utils/size_config.dart';
import '../utils/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final usersController = Get.put(UsersController());
    usersController.getMail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.all(20),
        width: SizeConfig.getScreenWidth(context) - 20,
        height: SizeConfig.getScreenHeight(context) - 20,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  kPrimaryColor,
                  kErrorColor,
                ])),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: SizeConfig.getScreenWidth(context) - 30,
            height: SizeConfig.getScreenHeight(context) - 30,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Padding(
                padding: const EdgeInsets.all(4),
                child: Obx(() => ListView.separated(
                      itemCount: controller.users.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: TextComponent(
                            controller.users[index].gender.name,
                            padding: const EdgeInsets.all(4),
                            fontSize: 10,
                          ),
                        );
                      },
                    ))),
          ),
        ),
      );
    });
  }
}
