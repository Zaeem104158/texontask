// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/text_component.dart';
import '../utils/size_config.dart';
import '../utils/style.dart';

class DetailsScreen extends StatelessWidget {
  String? image;

  String? state;

  String? city;

  String? country;

  String email;

  String? phone;
  DetailsScreen(
      {super.key,
      this.image,
      this.state,
      this.city,
      this.country,
      required this.email,
      this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Friends Details")),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        image!,
                        alignment: Alignment.center,
                      ),
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
                    GestureDetector(
                      onTap: () async {
                        String sendEmail = Uri.encodeComponent(email);
                        String subject = Uri.encodeComponent("Hello Flutter");
                        String body =
                            Uri.encodeComponent("Hi! I'm Flutter Developer");

                        Uri mail = Uri.parse(
                            "mailto:$sendEmail?subject=$subject&body=$body");
                        if (await launchUrl(mail)) {
                          //email app opened
                        } else {
                          //email app is not opened
                        }
                      },
                      child: TextComponent(
                        "Email:$email",
                        textAlign: TextAlign.start,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Uri phoneno = Uri.parse('tel:${phone!}');
                        if (await launchUrl(phoneno)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },
                      child: TextComponent(
                        "Phone:$phone ",
                        textAlign: TextAlign.start,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
