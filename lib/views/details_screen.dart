import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texontask/models/users_respone_model.dart';

import '../components/text_component.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../utils/style.dart';

class DetailsScreen extends StatelessWidget {
  String? image;

  String? state;

  String? city;

  String? country;

  String? email;

  String? phone;
  DetailsScreen(
      {super.key,
      this.image,
      this.state,
      this.city,
      this.country,
      this.email,
      this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Friends Details")),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          width: SizeConfig.getScreenWidth(context) - 20,
          height: 400,
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
                height: 390,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      image!,
                      alignment: Alignment.center,
                    ),
                    TextComponent(
                      "Country:$country ",
                      textAlign: TextAlign.start,
                      fontSize: 12,
                    ),
                    TextComponent(
                      "State:$state ",
                      textAlign: TextAlign.start,
                      fontSize: 12,
                    ),
                    TextComponent(
                      "City:$city ",
                      textAlign: TextAlign.start,
                      fontSize: 12,
                    ),
                    TextComponent(
                      "Email:$email ",
                      textAlign: TextAlign.start,
                      fontSize: 12,
                    ),
                    TextComponent(
                      "Phone:$phone ",
                      textAlign: TextAlign.start,
                      fontSize: 12,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
