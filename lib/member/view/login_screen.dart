import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/const/app_colors.dart';
import '../../common/const/app_strings.dart';
import '../../common/const/app_theme.dart';
import '../../common/const/data.dart';
import '../../common/layout/default_layout.dart';
import '../../common/widgets/background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.zero,
        children: [
          Background(
              height: MediaQuery.of(context).size.height * 0.1,
              children: [
                Text(
                  AppStrings.welcome,
                  style: AppTheme.title1,
                ),
                SizedBox(height: 6),
                Text(AppStrings.signInToYourAccount, style: AppTheme.title3)
              ]),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    hintText: "이메일을 입력해주세요",
                    onChanged: (String value) {
                      email = value;
                    },
                    textInputAction: TextInputAction.next,
                    labelText: AppStrings.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 18),
                  CustomTextFormField(
                    hintText: "비밀번호를 입력해주세요",
                    onChanged: (String value) {
                      password = value;
                    },
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    labelText: AppStrings.password,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      // ID:비밀번호
                      final rawString = '$email:$password';

                      print(rawString);

                      Codec<String, String> stringToBase64 = utf8.fuse(base64);

                      String token = stringToBase64.encode(rawString);

                      final response = await dio.post(
                        'http://$ip/auth/login',
                        options: Options(
                          headers: {
                            'Authorization': 'Basic $token',
                            'Content-Type': 'application/json',
                          },
                        ),
                      );
                      final refreshToken = response.data['refreshToken'];
                      final accessToken = response.data['accessToken'];

                      await storage.write(
                          key: REFRESH_TOKEN_KEY, value: refreshToken);
                      await storage.write(
                          key: ACCESS_TOKEN_KEY, value: accessToken);

                      /// Navigator 대신 MaterialApp을 새로 빌드
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              Scaffold(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                      print(response.data);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.PRIMARY_GREEN),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.doNotHaveAnAccount,
              ),
              const SizedBox(width: 4),
              //TextButton(onPressed: onPressed, child: child)
            ],
          )
        ],
      ),
    );
  }
}
