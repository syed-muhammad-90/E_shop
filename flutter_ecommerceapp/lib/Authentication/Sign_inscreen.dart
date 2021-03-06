
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


class Sign_in extends StatefulWidget {
  @override
  _Sign_inState createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  @override

  final TextEditingController _emailTextEdittingController=TextEditingController();

  final TextEditingController _passwordTextEdittingController=TextEditingController();

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  Widget build(BuildContext context) {


    double _screenwidth= MediaQuery.of(context).size.width, _screenHeight= MediaQuery.of(context).size.height;
    return SingleChildScrollView(


      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,

          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            CustomTextField(
//                      maxlength: 8,
              controller: _emailTextEdittingController,

              hintText: "Email",
              data: Icons.remove_red_eye,

              isObsecure: false,
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            CustomTextField(
//                      maxlength: 8,
              controller: _passwordTextEdittingController,
              data: Icons.remove_red_eye,

              hintText: "Password",
              isObsecure: false,
            ),
            DefaultButton(
                text: "Login",
                press: () {
                  _emailTextEdittingController.text.isNotEmpty && _passwordTextEdittingController.text.isNotEmpty ? LoginUser():showDialog(context: context
                  ,builder: (c){
                    return ErrorAlertDialog(message: "please type valid email password",);
                      });
                }


            )




          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth=FirebaseAuth.instance;


  void LoginUser() async{
    showDialog(
      context: context,
      builder: (c){
        return LoadingAlertDialog(message: "Autehnticating ....please wait",);

      }
    );

    FirebaseUser fUser;

    await _auth.signInWithEmailAndPassword(email: _emailTextEdittingController.text.trim(), password: _passwordTextEdittingController.text.trim()
    
    ).then((authUser) => fUser=authUser.user).catchError((error){
      Navigator.pop(context);
      showDialog(context: context,
          builder: (c){
            return ErrorAlertDialog(message: error.message.toString(),);
          });
    });

    if(fUser !=null) {
      readData(fUser).then((s){
        Navigator.pop(context);
        Route route=MaterialPageRoute(builder: (c)=>StoreHome());
        Navigator.pushReplacement(context, route);

      });


    }






  }

  Future readData(FirebaseUser fUser) {
Firestore.instance.collection("Users").document(fUser.uid).get().then((dataSnapshot) async {
  await EcommerceApp.sharedPreferences.setString("uid" ,dataSnapshot.data[EcommerceApp.userUID]);
  await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName ,dataSnapshot.data[EcommerceApp.userName]);
  await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail ,dataSnapshot.data[EcommerceApp.userEmail]);
//  List<String> cartlist=dataSnapshot.data[EcommerceApp.userCartList].cast<String>();

//  await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,cartlist);


});
  }
}
