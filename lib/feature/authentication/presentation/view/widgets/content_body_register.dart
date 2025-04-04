import 'package:collab_doc/feature/authentication/presentation/view/widgets/have_account.dart';
import 'package:flutter/material.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_button.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_image.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_text_field.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_title.dart';
import 'package:collab_doc/core/utils/assets.dart';
import 'package:collab_doc/core/utils/function/validator.dart';

class content_body_register extends StatelessWidget {
  const content_body_register({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController email;
  final TextEditingController username;
  final TextEditingController password;
  final TextEditingController phone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(
                  url: AssetsImage.docs,
                ),
                CustomTitle(
                  title: "Register",
                  subtitle:
                      "Create, edit, and collaborate on documents in real time—anytime, anywhere",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const SizedBox(height: 10),
                CustomTextField(
                  obscureText: false,
                  validator: (val) {
                    return validateEmail(val);
                  },
                  controller: email,
                  hintText: "Enter your email",
                  suffixIcon: Icon(Icons.email),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  obscureText: false,
                  validator: (val) {
                    return validateFullName(val);
                  },
                  controller: username,
                  hintText: "Enter your username",
                  suffixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  obscureText: false,
                  validator: (val) {
                    return validatePhone(val);
                  },
                  controller: phone,
                  hintText: "Enter your phone",
                  suffixIcon: Icon(Icons.phone),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  obscureText: true,
                  validator: (val) {
                    return validatePassword(val);
                  },
                  controller: password,
                  hintText: "Enter your password",
                  suffixIcon: Icon(Icons.lock),
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: "Register",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Have_Account(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
