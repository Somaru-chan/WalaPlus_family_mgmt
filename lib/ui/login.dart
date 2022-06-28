import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';
import 'package:walaplus_family_mgmt/custom/textfield_design.dart';
import 'package:walaplus_family_mgmt/services/auth_services.dart';
import 'package:walaplus_family_mgmt/ui/dashboard.dart';
import 'package:walaplus_family_mgmt/ui/home.dart';
import 'package:walaplus_family_mgmt/ui/restore_password.dart';
import 'package:walaplus_family_mgmt/ui/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

            //Sign In Title
            const Text('تسجيل الدخول',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),),

            SizedBox(height: scHeight*0.04,),

            //email textfield
            Container(
              child: TextFieldDesign.textFieldStyle(
                context: context,
                controller: emailController,
                kbType: TextInputType.emailAddress,
                obscTxt: false,
                lbTxt: 'البريد الإلكتروني ',
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: scHeight*0.02,),

            //password textfield
            Container(
              child: TextFieldDesign.textFieldStyle(
                context: context,
                controller: passwordController,
                kbType: TextInputType.visiblePassword,
                obscTxt: true,
                lbTxt: 'كلمة المرور',
                // textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: scHeight*0.02,),

            //forgot password? text
            InkWell(
              child: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text('نسيت كلمة المرور؟',
                style: TextStyle(
                  color: kPrimaryGreen,
                  fontSize: 17
                ),),
              ),
              onTap: () {
                Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (context) => RestorePasswordScreen()));
              },
            ),

            SizedBox(height: scHeight*0.06,),

            //sign in button
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fixedSize: Size(scWidth/1.13, scHeight/15),
                backgroundColor: kPrimaryGreen,
              ),
              onPressed: () {
                final String email = emailController.text.trim().contains('@') ? emailController.text.trim() : '';
                final String phone = emailController.text.trim().contains('@') ? '' : emailController.text.trim();
                final String password = passwordController.text.trim();

                print('email is: $email');
                print('phone is: $phone');
                print('pw is: $password');

                if(email.isEmpty && phone.isEmpty) {
                  print('Email and phone are empty!');
                } else {
                    if(password.isEmpty) {
                     print('Password is empty!'); 
                    } else {
                        context.read<AuthService>().emailLogin(email, password);
                        Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder: (context) => DashboardScreen()));
                    }
                }
              }, 
              child: const Text('تسجيل الدخول', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),)),

            SizedBox(height: scHeight*0.06,),

            //sign up hypertext
            InkWell(
              child: const Text('ليس لديك حساب؟',
              style: TextStyle(
                color: kPrimaryGreen,
                fontSize: 17
              ),),
              onTap: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            ),


          ],
        ),
      ),
    );
  }
}