import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerceapp/constrains/consttrains.dart';
import 'package:flutter_ecommerceapp/splash/splash_screen.dart';
import 'Counters/BookQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenication.dart';
import 'package:flutter_ecommerceapp/Config/config.dart';
import 'Counters/cartitemcounter.dart';
import 'Counters/changeAddresss.dart';
import 'Counters/totalMoney.dart';
import 'Store/storehome.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.auth =FirebaseAuth.instance;
  EcommerceApp.sharedPreferences =await   SharedPreferences.getInstance();
  EcommerceApp.firestore =Firestore.instance;


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "flutter e commerce",
      theme:  ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Muli",
        textTheme: TextTheme(
          bodyText1: TextStyle(color: kTextColor),
          bodyText2: TextStyle(color: kTextColor),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,


      ),
      home:SplashScreen(),

    );
  }
}
////
////class SplashScreen extends StatefulWidget {
////  @override
////  _SplashScreenState createState() => _SplashScreenState();
////}
////
////
////class _SplashScreenState extends State<SplashScreen>
////{
////
////  @override
////  void initState() {
////    // TODO: implement initState
////    super.initState();
////    Displaysplashscreen();
////
////  }
////  @override
////  Widget build(BuildContext context) {
////
////
////    return Scaffold(
////
////
////
////    );
////  }
////
////  void Displaysplashscreen(){
////
////    Timer(Duration(seconds: 5), () async{
////      if (await EcommerceApp.auth.currentUser() !=null ){
////        Route route=MaterialPageRoute(builder: (_)=> StoreHome());
////        Navigator.pushReplacement(context,route);
////      }
////      else {
////        Route route=MaterialPageRoute(builder: (_)=> AuthenticScreen());
////        Navigator.pushReplacement(context,route);
////
////      }
////
////    });
////  }
//}
