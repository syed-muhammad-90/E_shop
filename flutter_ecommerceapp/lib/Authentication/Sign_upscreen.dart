

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerceapp/Components/default_button.dart';
import 'package:flutter_ecommerceapp/Config/config.dart';
import 'package:flutter_ecommerceapp/DialogBox/errorDialog.dart';
import 'package:flutter_ecommerceapp/DialogBox/loadingDialog.dart';
import 'package:flutter_ecommerceapp/Store/storehome.dart';
import 'package:flutter_ecommerceapp/Widgets/customTextField.dart';
import 'package:flutter_ecommerceapp/constrains/size_config.dart';


class Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  @override


  final TextEditingController _nameTextEdittingController=TextEditingController();

  final TextEditingController _emailTextEdittingController=TextEditingController();

  final TextEditingController _passwordTextEdittingController=TextEditingController();

  final TextEditingController _cpasswordnameTextEdittingController=TextEditingController();

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  ScrollController _scrollController;

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      
      child: Container(
        padding: const EdgeInsets.all(10.0),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: double.infinity,
            child:Column(
              children: [
                Text("Register Page ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0)),
                Text(" submit your details ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0))
              ],
            ),),

            Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomTextField(
//                      maxlength: 10,

                      controller: _nameTextEdittingController,
                      data: Icons.person_add,
                      hintText: "Username",
                      isObsecure: false,


                    ),

                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomTextField(
//                      maxlength: 8,
                      controller: _passwordTextEdittingController,

                      hintText: "Password",
                      data: Icons.remove_red_eye,

                      isObsecure: true,
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomTextField(
//                      maxlength: 8,
                      controller: _cpasswordnameTextEdittingController,
                      data: Icons.remove_red_eye,

                      hintText: "Confirm Password",
                      isObsecure: true,
                    ),


                    SizedBox(height: getProportionateScreenHeight(10)),
                    CustomTextField(
//                      maxlength: 20,
                      controller: _emailTextEdittingController,

                      hintText: "Email",
                      data: Icons.email_outlined,
                      email: " like Syedmuhammadshaheryar0@gmail.com",
                      isObsecure: false,
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                     DefaultButton(
        text: "Submit",
        press: () =>  uploaddata())




                  ],


                ),
              )

          ],
        ),

      ),
    );
  }

  Future <void>uploaddata() async{
    if(_emailTextEdittingController.text.isEmpty==null  && _nameTextEdittingController.text.isEmpty==null )
      {
        showDialog(context: context,builder: (c){
          // ignore: missing_return
          return ErrorAlertDialog(message: "please put right details ");
        });


      }
    else{
      _passwordTextEdittingController.text==_cpasswordnameTextEdittingController.text ?
      _emailTextEdittingController.text.isNotEmpty && _passwordTextEdittingController.text.isNotEmpty &&
    _cpasswordnameTextEdittingController.text.isNotEmpty && _nameTextEdittingController.text.isNotEmpty
          ? uploadTo_storage():
      displaydialog("please  fill up registration form "):
          displaydialog("password  do not match");




    }



  }

  uploadTo_storage() async{
    showDialog(context: context,builder: (c){
      return LoadingAlertDialog(message: "please  wait for authentication",);
    });
    _registerUser();




  }

  displaydialog(String msg) async{
    showDialog(context: context,builder: (c){
    return ErrorAlertDialog(message: msg);

    });

  }
FirebaseAuth _auth =FirebaseAuth.instance;
  void _registerUser() async{
    FirebaseUser firebaseUser;
    await _auth.createUserWithEmailAndPassword(email: _emailTextEdittingController.text.trim(), password: _passwordTextEdittingController.text.trim()
    ).then((auth) => firebaseUser=auth.user).catchError((error){
      Navigator.pop(context);
      showDialog(context: context,
      builder: (c){
        return ErrorAlertDialog(message: error.message.toString(),);
      });
    });

    //ifnirebaseus nt equal to null means data
    if(firebaseUser !=null){
      SaveUserInfoFirebase(firebaseUser).then((value){
        Navigator.of(context);
        Route route =MaterialPageRoute(builder:(c)=> StoreHome()
        );
        Navigator.pushReplacement(context, route);



      });
      
    }





  }

  Future  SaveUserInfoFirebase(FirebaseUser fUser) async{
    Firestore.instance.collection("Users").document(fUser.uid).setData({
      "uid":fUser.uid,

      "email":fUser.email,
      "name": _nameTextEdittingController.text.trim(),
//   EcommerceApp.userCartList:["garbageValue"],
    }
    );
    await EcommerceApp.sharedPreferences.setString("uid" ,fUser.uid);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail ,fUser.email);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName ,_nameTextEdittingController.text);
//    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,["garbage value"]);



  }



}

