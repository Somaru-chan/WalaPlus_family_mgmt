import 'package:flutter/material.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';
import 'package:walaplus_family_mgmt/custom/textfield_design.dart';
import 'package:walaplus_family_mgmt/ui/login.dart';

class RestorePasswordScreen extends StatefulWidget {
  const RestorePasswordScreen({ Key? key }) : super(key: key);

  @override
  State<RestorePasswordScreen> createState() => _RestorePasswordScreenState();
}

class _RestorePasswordScreenState extends State<RestorePasswordScreen> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70,),
            //brandName
            SizedBox(
              width: scWidth*0.28,
              height: scHeight*0.2,
              child: Image.asset('assets/images/brandname.png'),
            ),
            SizedBox(height: scHeight*0.01,),

            //Restore Password Title
            const Text('استعادة كلمة المرور',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),),

            SizedBox(height: scHeight*0.03,),

            //Restore Password Instruction
            const Text('أدخل البريد الإلكتروني لاسترداد الرمز السري',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),),

            SizedBox(height: scHeight*0.04,),

            //email textfield
            Container(
              child: TextFieldDesign.textFieldStyle(
                context: context,
                controller: emailController,
                kbType: TextInputType.name,
                obscTxt: false,
                lbTxt: 'البريد الإلكتروني أو رقم الجوال',
              ),
            ),

            SizedBox(height: scHeight*0.04,),

            //sign in button
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: Size(scWidth/1.13, scHeight/15),
                backgroundColor: kPrimaryGreen,
              ),
              //TODO: Firebase Auth ForgotPW
              onPressed: () {

              }, 
              child: const Text('متابعة', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),)),

            SizedBox(height: scHeight*0.06,),

            //sign up hypertext
            InkWell(
              child: const Text('رجوع لتسجيل الدخول',
              style: TextStyle(
                color: kPrimaryGreen,
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),),
              onTap: () {
                Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (context) => LoginScreen()));


              },
            ),


          ],
        ),
      ),
    );
  }
}