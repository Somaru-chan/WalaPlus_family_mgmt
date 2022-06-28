import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';
import 'package:walaplus_family_mgmt/ui/dashboard.dart';
import 'package:walaplus_family_mgmt/ui/home.dart';
import 'package:walaplus_family_mgmt/ui/login.dart';

import '../services/auth_services.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({ Key? key }) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            fixedSize: Size(
              MediaQuery.of(context).size.width*0.4, 
              MediaQuery.of(context).size.height*0.055
            ),
            backgroundColor: kPrimaryGreen,
          ),
          child: const Text( 'تسجيل الخروج', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // fontSize:
          ),),
          onPressed: () {
            //TODO: test log out
            context.read<AuthService>().logOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => DashboardScreen())));
          },
        ),
      ),
    );
  }
}