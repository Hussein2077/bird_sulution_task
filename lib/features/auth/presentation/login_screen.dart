import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/resource_manager/asset_path.dart';
import 'package:flutter_task/core/resource_manager/colors.dart';
import 'package:flutter_task/core/resource_manager/routes.dart';
import 'package:flutter_task/core/resource_manager/string_manager.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/features/auth/presentation/controller/login_bloc/login_with_email_and_password_bloc.dart';
import 'package:flutter_task/features/auth/presentation/controller/login_bloc/login_with_email_and_password_events.dart';
import 'package:flutter_task/features/auth/presentation/controller/login_bloc/login_with_email_and_password_states.dart';
import 'package:flutter_task/features/auth/presentation/widgets/auth_button.dart';
import 'package:flutter_task/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter_task/features/auth/presentation/widgets/social_auth_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SnackBar snackBar = const SnackBar(
      content: Text('please fill your data'),
      backgroundColor: Colors.red,
    );
    AppSize().init(context);
    return BlocConsumer<LoginWithEmailAndPasswordBloc,
        LoginWithEmailAndPasswordState>(
      listener: (context, state) {
        if (state is LoginWithEmailAndPasswordSuccessMessageState) {
          log(state.successMessage);
          Navigator.pushNamed(context, Routes.home);
        } else if (state is LoginWithEmailAndPasswordErrorMessageState) {
          SnackBar snackBar = const SnackBar(
            content: Text('Please enter correct data'),
            backgroundColor: Colors.red,
          );
          log(state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSize.defaultSize! * 14.1,
                    ),
                    Text(
                      StringManager.welcomeBack,
                      style: TextStyle(
                          fontSize: AppSize.defaultSize! * 2,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor),
                    ),
                    SizedBox(
                      height: AppSize.defaultSize!,
                    ),
                    Text(
                      StringManager.loginToContinue,
                      style: TextStyle(
                          fontSize: AppSize.defaultSize! * 1.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor),
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 5,
                    ),
                    CustomTextField(
                      labelText: StringManager.email,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 2,
                    ),
                    CustomTextField(
                      labelText: StringManager.password,
                      controller: passwordController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 1.3,
                    ),
                    SizedBox(
                      width:
                          AppSize.screenWidth! - (AppSize.defaultSize! * 3.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.greyColor
                                              .withOpacity(.4)),
                                      shape: BoxShape.circle),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.backgroundColor,
                                    radius: AppSize.defaultSize! * .7,
                                    child: Icon(
                                      Icons.check,
                                      size: AppSize.defaultSize! * 1.2,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppSize.defaultSize! * .5,
                              ),
                              Text(
                                StringManager.rememberMe,
                                style: TextStyle(
                                    fontSize: AppSize.defaultSize! * 1.5,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor),
                              ),
                            ],
                          ),
                          InkWell(
                            child: Text(
                              StringManager.forgetPassword,
                              style: TextStyle(
                                  fontSize: AppSize.defaultSize! * 1.4,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greyColor.withOpacity(.8)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 2.4,
                    ),
                    AuthButton(
                        onTap: () {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            BlocProvider.of<LoginWithEmailAndPasswordBloc>(
                                    context)
                                .add(LoginWithEmailAndPasswordEvent(
                                    phone: emailController.text,
                                    password: passwordController.text));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        widget: Text(
                          StringManager.login,
                          style: TextStyle(
                              fontSize: AppSize.defaultSize! * 1.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor),
                        ),
                        color: AppColors.primaryColor),
                    SizedBox(
                      height: AppSize.defaultSize! * 2.7,
                    ),
                    Text(
                      StringManager.or,
                      style: TextStyle(
                          fontSize: AppSize.defaultSize! * 1.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor),
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 2.7,
                    ),
                    AuthButton(
                        widget: SocialAuthRow(
                          icon: Image.asset(
                            AssetPath.google,
                            scale: 15,
                          ),
                          text: StringManager.google,
                          textColor: AppColors.blackColor,
                        ),
                        color: AppColors.whiteColor),
                    SizedBox(
                      height: AppSize.defaultSize! * 2.7,
                    ),
                    AuthButton(
                        widget: SocialAuthRow(
                          icon: Image.asset(
                            AssetPath.apple,
                            color: Colors.white,
                            scale: 15,
                          ),
                          text: StringManager.apple,
                          textColor: AppColors.whiteColor,
                        ),
                        color: AppColors.blackColor),
                    SizedBox(
                      height: AppSize.defaultSize! * 2.7,
                    ),
                    AuthButton(
                        widget: SocialAuthRow(
                          icon: Image.asset(
                            AssetPath.facebook,
                            scale: 15,
                          ),
                          text: StringManager.facebook,
                          textColor: AppColors.whiteColor,
                        ),
                        color: AppColors.facebookColor),
                    SizedBox(
                      height: AppSize.defaultSize! * 2.7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringManager.doNotHaveAccount,
                          style: TextStyle(
                              fontSize: AppSize.defaultSize! * 1.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor),
                        ),
                        InkWell(
                          child: Text(
                            StringManager.signUp,
                            style: TextStyle(
                                fontSize: AppSize.defaultSize! * 1.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 4,
                    ),
                    Text(
                      StringManager.bySigningUp,
                      style: TextStyle(
                          fontSize: AppSize.defaultSize! * 1.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringManager.agreed,
                          style: TextStyle(
                              fontSize: AppSize.defaultSize! * 1.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyColor),
                        ),
                        Text(
                          StringManager.termsOfService,
                          style: TextStyle(
                              fontSize: AppSize.defaultSize! * 1.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.defaultSize! * 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
