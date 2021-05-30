import 'package:dershane/extensions/renkler.dart';
import 'package:flutter/material.dart';
import 'package:dershane/extensions/size_extention.dart';


class Myinput extends StatelessWidget {
  final String hintText;
  final String errortext;
  final int satir;
  final  TextEditingController controller;
  final  FocusNode focusNode;
  final Widget icon;
  final FormFieldValidator<String> validate;
  final FormFieldSetter<String>  onSaved;
  final ValueChanged<String> onchange;
  final TextInputType keybordType;
  final bool passwordVisible;

  const Myinput(
      {Key key,
        @required this.hintText,
        @required this.errortext,
        @required this.satir,
        @required this.controller,
        @required this.validate,
        @required this.icon,
        @required this.onSaved,
        @required this.focusNode,
        @required this.onchange,
        @required this.keybordType,
        @required this.passwordVisible
      })
      : assert(hintText != null, onSaved != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0.w),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0.w),
          child: SizedBox(
            height: 55.0.h,
            child: TextFormField(
              controller: controller,
              onChanged: onchange,
              validator: validate,
              style: TextStyle(
                fontSize: 16.0.spByWidth,
              ),
              cursorColor: Colors.blue,
              obscureText: passwordVisible,
              keyboardType: keybordType,
              decoration:InputDecoration(
                  helperText: "   ",
                  icon: Padding(
                    padding:  EdgeInsets.only(top: 13.0.h,left: 10.0.w),
                    child: icon,
                  ),

                  border: InputBorder.none,
                  contentPadding:  const EdgeInsets.only(),
                  errorStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  hintText: hintText,hintStyle: TextStyle(color: Colors.black87)),
            ),
          ),
        ),
      ),
    );
  }
}
