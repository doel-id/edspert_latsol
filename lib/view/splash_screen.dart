import 'dart:async';

import 'package:flutter/material.dart';
import 'package:edspert_latsol/constants/r.dart';
import 'package:edspert_latsol/helpers/user_email.dart';
import 'package:edspert_latsol/models/network_response.dart';
import 'package:edspert_latsol/models/user_by_email.dart';
import 'package:edspert_latsol/repository/auth_api.dart';
import 'package:edspert_latsol/view/login_page.dart';
import 'package:edspert_latsol/view/main_page.dart';
import 'package:edspert_latsol/view/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = "spash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final user = UserEmail.getUserEmail();

      if (user != null) {
        final dataUser = await AuthApi().getUserByEmail();
        if (dataUser.status == Status.success) {
          final data = UserByEmail.fromJson(dataUser.data!);
          if (data.status == 1) {
            Navigator.of(context).pushReplacementNamed(MainPage.route);
          } else {
            Navigator.of(context).pushReplacementNamed(RegisterPage.route);
          }
        }
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.primary,
      body: Center(
        child: Image.asset(
          R.assets.icSplash,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
