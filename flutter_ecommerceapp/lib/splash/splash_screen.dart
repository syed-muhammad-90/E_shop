import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerceapp/Authentication/authenication.dart';
import 'package:flutter_ecommerceapp/Config/config.dart';
import 'package:flutter_ecommerceapp/Store/storehome.dart';
import 'package:flutter_ecommerceapp/constrains/size_config.dart';
import 'package:flutter_ecommerceapp/splash/components/body.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Displaysplashscreen();
  }

  void Displaysplashscreen() {
    Timer(Duration(seconds: 60), () async {
      if (await EcommerceApp.auth.currentUser() != null) {
        Route route = MaterialPageRoute(builder: (_) => StoreHome());
        Navigator.pushReplacement(context, route);
      }
      else {
        Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
        Navigator.pushReplacement(context, route);
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}