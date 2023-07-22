import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/text_component.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../utils/style.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     TextComponent(
          //       "${controller.users[index].name.title} ${controller.users[index].name.first} ${controller.users[index].name.last}",
          //       textAlign: TextAlign.start,
          //       fontSize: 12,
          //     ),
          //     TextComponent(
          //       controller.users[index].location.country,
          //       textAlign: TextAlign.start,
          //       fontSize: 12,
          //     ),
          //   ],
          // )
        ),
      ),
    );
    ;
  }
}
