import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texontask/views/details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../components/text_component.dart';
import '../controller/user_controller.dart';
import '../utils/constants.dart';
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
    usersController.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(builder: (controller) {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 3.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: controller.users.length,
          itemBuilder: (BuildContext ctx, index) {
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
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const DetailsScreen(),
                            transition: sendTransition, arguments: []);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            child: CachedNetworkImage(
                                imageUrl:
                                    controller.users[index].picture.medium,
                                color: Colors.black.withOpacity(0.2),
                                colorBlendMode: BlendMode.darken,
                                height: 100,
                                width: 150,
                                progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                    SizedBox(
                                        //height: 80,
                                        child: Padding(
                                      padding: const EdgeInsets.all(.0),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: Colors.red.withOpacity(0.3)),
                                      ),
                                    )),
                                fit: BoxFit.fill),
                          ),
                          TextComponent(
                            "Full Name: ${controller.users[index].name.title} ${controller.users[index].name.first} ${controller.users[index].name.last}",
                            textAlign: TextAlign.left,
                            fontSize: 12,
                            padding: const EdgeInsets.all(4),
                          ),
                          TextComponent(
                            "Country: ${controller.users[index].location.country}",
                            textAlign: TextAlign.start,
                            fontSize: 12,
                            padding: const EdgeInsets.all(4),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          });
    });
  }
}
