import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget
{
  final TextEditingController controller;
  final IconData data;
  final maxlength;
  final String hintText;
  final String email;
  bool isObsecure = true;



  CustomTextField(
      {Key key, this.controller,this.email, this.data, this.hintText,this.isObsecure,this.maxlength}
      ) : super(key: key);



  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      

      child: TextFormField(


        controller: controller,
        maxLength: maxlength,

        obscureText: isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
//          labelText: "Email",
          hintText: hintText,
          helperText: email,
          suffixIcon: Icon(data,color: Colors.grey,),

          border: OutlineInputBorder(
  borderRadius: new BorderRadius.circular(20.0),
  borderSide: new BorderSide(
  )),
  floatingLabelBehavior: FloatingLabelBehavior.always,

        ),
      ),
    );
  }
}
