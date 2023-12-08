// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static String routeName = 'loginPage';
  String? password;

  String? email;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        }
        else if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.routName , arguments: email);
          isLoading = false;
        }
        else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder:(context , state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kprimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 75),
                  Image.asset(
                    klogo,
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scolar Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 75),
                  const Row(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data) => email = data,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    obscureText: true,
                    onChanged: (pass) => password = pass,
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButtom(
                    title: 'Sign In',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).
                        loginUser(email: email!, password: password!);
                      }
                      
                      }
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('don\'t have an account ?',
                          style: TextStyle(color: Colors.white)),
                      GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, SignUpPage.routeName),
                          child: const Text(
                            '  Sign Up',
                            style: TextStyle(color: Color(0xffC7EDE6)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    // ignore: unused_local_variable
    UserCredential auth = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}



