import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/authentication/presentation/manager/cubit/authentication_cubit.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/content_body_login.dart';
import 'package:collab_doc/feature/home/presentation/manager/cubit/home_cubit.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    //String? errorMessage;

    return SafeArea(
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            snackbarerror(context, state.errorMessage);
          }
          if (state is LoginSuccess) {
            infoUserSharedPreferences.setString("token", state.token);
            BlocProvider.of<AuthenticationCubit>(context)
                .updateStatustoActive();
            BlocProvider.of<HomeCubit>(context).getUserDetails();
            Navigator.of(context)
                .pushNamedAndRemoveUntil("home", (route) => false);
          }
        },
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: content_body_login(
                    formKey: formKey,
                    username: username,
                    password: password,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
