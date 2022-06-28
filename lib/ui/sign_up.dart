import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';
import 'package:walaplus_family_mgmt/custom/textfield_design.dart';
import 'package:walaplus_family_mgmt/services/auth_services.dart';
import 'package:walaplus_family_mgmt/ui/dashboard.dart';
import 'package:walaplus_family_mgmt/ui/home.dart';
import 'package:walaplus_family_mgmt/ui/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String gender = '';
  bool pwMatch = false;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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

            //Sign Up Title
            const Text('إنشاء حساب جديد',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),),

            SizedBox(height: scHeight*0.04,),

            //TODO: Add validator to all fields

            //email textfield
            Container(
              child: TextFieldDesign.textFieldStyle(
                context: context,
                controller: firstNameController,
                kbType: TextInputType.name,
                obscTxt: false,
                lbTxt: 'الاسم الأول',
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: scHeight*0.02,),

            //email textfield
            Container(
              child: TextFieldDesign.textFieldStyle(
                context: context,
                controller: lastNameController,
                kbType: TextInputType.name,
                obscTxt: false,
                lbTxt: 'اسم العائلة',
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: scHeight*0.02,),

            //email textfield
            Container(
              child: TextFieldDesign.textFieldStyle(
                context: context,
                controller: emailController,
                kbType: TextInputType.emailAddress,
                obscTxt: false,
                lbTxt: 'البريد الإلكتروني',
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: scHeight*0.02,),

            //phone num textfield
            Container(
              child: TextFieldDesign.textFieldStyle(
                context: context,
                controller: phoneController,
                kbType: TextInputType.phone,
                obscTxt: false,
                lbTxt: 'رقم الجوال',
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
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: scHeight*0.02,),

            //password textfield
            Container(
              child: TextFieldDesign.textFieldStyle(
                context: context,
                controller: confirmPasswordController,
                kbType: TextInputType.visiblePassword,
                obscTxt: true,
                lbTxt: 'تأكيد كلمة المرور',
                validat: (value) {
                  pwMatch = confirmPasswordController.text == passwordController.text;
                  if (pwMatch) {
                    return '';
                  } else {
                    return 'كلمتا السر غير متطابقتين';
                  }
                }
              ),
            ),
            SizedBox(height: scHeight*0.02,),
            
            //Gender tabs
            ToggleSwitch(
              initialLabelIndex: 1,
              minWidth: scWidth*0.44,
              minHeight: scHeight*0.07,
              cornerRadius: 18.0,
              totalSwitches: 2,
              labels: const ['أنثى', 'ذكر'],
              fontSize: 16,
              inactiveBgColor: Colors.grey.shade100,
              activeBgColor: const [kPrimaryGreen],
              inactiveFgColor: kPrimaryGreen,
              onToggle: (index) {
                print('switched to: $index');
                gender = index == 0 ? 'female' : 'male';
                print(gender);
              },
            ),

            SizedBox(height: scHeight*0.035,),
            //Agree to the following text
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: const Text('بالضغط على زر التسجيل أوافق على التالي',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16
              ),),
            ),
            SizedBox(height: scHeight*0.02,),

            // text
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Terms and Conditions
                    InkWell(
                      child: const Text('  الشروط والأحكام',
                      style: TextStyle(
                        color: kPrimaryGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.w100
                      ),),
                      onTap: () {
                        //redirect to T&Cs page
                      },
                    ),
            
                    //and Text
                    const Text('   و  ', 
                      style: TextStyle(
                        color: Colors.grey
                      ),),
            
                    //Privacy Policy
                    InkWell(
                      child: const Text(' سياسة الخصوصية ',
                      style: TextStyle(
                        color: kPrimaryGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.w100
                      ),),
                      onTap: () {
                        //redirect to PriPol page
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: scHeight*0.05,),

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
                final String email = emailController.text.trim();
                final String phone = phoneController.text.trim();
                final String password = passwordController.text.trim();
                final String firstName = firstNameController.text.trim();
                final String lastName = lastNameController.text.trim();

                print('email is: $email');
                print('phone is: $phone');
                print('pw is: $password');

                if(email.isEmpty) {
                  print('Email is empty!');
                } else {
                  if(phone.isEmpty) {
                    print('Phone number is empty!');
                  } else {
                    if(password.isEmpty || pwMatch == false) {
                     print("Password is empty or passwords don't match!"); 
                    } else {
                       if(firstName.isEmpty) {
                        print('First name is empty!');
                       } else {
                        if(lastName.isEmpty) {
                          print('Last name is empty!');
                        } else {
                          if(gender.isEmpty) {
                            print('Gender is empty!');
                          } else {
                            context.read<AuthService>().signUp(
                              email, 
                              password).then((value) async {
                                User? user = FirebaseAuth.instance.currentUser;
                                await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
                                  'uid': user?.uid,
                                  'email': email,
                                  'password': password,
                                  'firstName': firstName,
                                  'lastName': lastName,
                                  'phone': phone,
                                  'gender': gender,
                                  'invites': 0,
                                  'invited': 0, 
                                  'points': 0
                                });
                              });
                              Navigator.pushReplacement(context, 
                                MaterialPageRoute(builder: (context) => DashboardScreen()));

                          }
                        }
                       }
                    }
                  }
                }
              }, 
              child: const Text('تسجيل', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),)),

            SizedBox(height: scHeight*0.06,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //sign up hypertext
                InkWell(
                  child: const Text('تسجيل الدخول',
                  style: TextStyle(
                    color: kPrimaryGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  onTap: () {
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),

                SizedBox(width: scWidth*0.05,),

                const Text('لديك حساب؟',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                ),),                
              ],
            ),

            SizedBox(height: scHeight*0.1,)


          ],
        ),
      ),
    );
  }
}