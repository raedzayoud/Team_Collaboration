import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_button.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_image.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_password_forget.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_text_field.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_title.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/signup.dart';
import 'package:collab_doc/core/utils/assets.dart';
import 'package:collab_doc/core/utils/function/validator.dart';
import 'package:flutter/material.dart';

class content_body_login extends StatelessWidget {
  const content_body_login({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.email,
    required this.password,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header
              CustomImage(
                url: AssetsImage.docs,
              ),
              const CustomTitle(
                title: "Welcome Back",
                subtitle:
                    "Create, edit, and collaborate on documents in real time—anytime, anywhere",
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              //Body
              CustomTextField(
                obscureText: false,
                validator: (val) {
                  return validateEmail(val);
                },
                controller: email,
                hintText: "Enter your email",
                suffixIcon: Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                obscureText: true,
                validator: (val) {
                  return validatePassword(val);
                },
                controller: password,
                hintText: "Enter your password",
                suffixIcon: Icon(Icons.lock),
              ),
              SizedBox(
                height: 10,
              ),
              CustomPasswordForget(),

              const SizedBox(height: 20),
              // Nav
              CustomButton(
                text: "Login",
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil("home", (route)=>false);
                  if (_formKey.currentState!.validate()) {}
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or"),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              CustomButton(
                text: "Continue with Google",
                onPressed: () {
                  // try {
                  //   BlocProvider.of<AuthenticationCubit>(context)
                  //       .signInWithGoogle();
                  // } on Exception catch (e) {
                  //   // TODO
                  // }
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Signup(),
            ],
          ),
        ),
      ),
    );
  }
}
