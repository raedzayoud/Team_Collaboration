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
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.width(context) * 0.05, vertical: AppResponsive.heigth(context) * 0.25),
          child: Center(
            child: Container(
              width: AppResponsive.width(context) > 600 ? 500 : double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextformFieldSettings(
                      controller: usernameController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextformFieldSettings(
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextformFieldSettings(
                      controller: phoneController,
                    ),
                    const SizedBox(height: 30),
                    ButtonsSettings(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
