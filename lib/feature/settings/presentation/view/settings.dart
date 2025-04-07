import 'package:collab_doc/core/utils/responsive.dart';
import 'package:collab_doc/feature/settings/presentation/view/widgets/buttonsettings.dart';
import 'package:collab_doc/feature/settings/presentation/view/widgets/customtextfieldsettings.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController usernameController =
      TextEditingController(text: 'raed zayoud');
  final TextEditingController emailController =
      TextEditingController(text: "raed@gmail.com");
  final TextEditingController phoneController =
      TextEditingController(text: "+216 27740388");
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Personal Information",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )),
                SizedBox(
                  height: AppResponsive.heigth(context) * .3,
                ),
                const Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextformFieldSettings(
                  controller: usernameController,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextformFieldSettings(
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Phone Number",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomTextformFieldSettings(
                  controller: phoneController,
                ),
                SizedBox(
                  height: 5,
                ),
                const SizedBox(height: 30),
                ButtonsSettings()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
