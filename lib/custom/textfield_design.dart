import 'package:flutter/material.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';

class TextFieldDesign{

  static textFieldStyle({context, TextEditingController? controller, TextInputType? kbType, String? lbTxt, validat, enabled, obscTxt, textInputAction}) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width/1.13,
      height: MediaQuery.of(context).size.height/13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          enabled: enabled,
          obscureText: obscTxt,
          controller: controller,
          keyboardType: kbType,
          textInputAction: textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validat,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            labelText: lbTxt,
            labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400
            ),
            contentPadding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            errorStyle: const TextStyle(
              fontSize: 12,
            ),
            focusColor: Colors.black,
            border: InputBorder.none,
            counterText: "",
          ),
        ),
      ),
    );
  }


  static plainTextFieldStyle(context, {controller, kbType, textInputAction, validat, String? htTxt}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        keyboardType: kbType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validat,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryGreen),
            borderRadius: BorderRadius.circular(40),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kSecondaryOrange),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kSecondaryOrange),
            borderRadius: BorderRadius.circular(40),
          ),
          hintText: htTxt,
          hintStyle: TextStyle(
            color: Colors.grey[400]
          ),
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          errorStyle: const TextStyle(
            fontSize: 12,
          ),
          focusColor: Colors.black,
          border: InputBorder.none,
          counterText: "",
        ),
      )
    );
  }
}