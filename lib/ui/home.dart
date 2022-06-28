// ignore_for_file: prefer_const_constructors


import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';
import 'package:walaplus_family_mgmt/custom/member_card_design.dart';
import 'package:walaplus_family_mgmt/custom/textfield_design.dart';
import 'package:walaplus_family_mgmt/services/auth_services.dart';
import 'package:walaplus_family_mgmt/ui/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final CollectionReference _members = 
    FirebaseFirestore.instance.collection('members');
  final CollectionReference _users = 
    FirebaseFirestore.instance.collection('users');
  final CollectionReference _invites = 
    FirebaseFirestore.instance.collection('invites');
  final CollectionReference _invited = 
    FirebaseFirestore.instance.collection('invited');

  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  //get number of invites
  // int getInvites() {
    // final int invitesNo =  _invites.snapshots().length.toString(); 

    // return invitesNo;
  // }

  //add points method
  Future<void> _addPoints([DocumentSnapshot? documentSnapshot]) async {
    
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //cancel icon button 
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kPrimaryGreen)
                    ),
                    child: IconButton(
                      iconSize: 35,
                      onPressed: (() => Navigator.pop(context)), 
                      icon: Transform.rotate(
                        angle: 45 * pi / 180,
                        child: Icon(Icons.add, 
                          color: kPrimaryGreen,)
                          ),
                        ),
                  ),
                ],
              ),

              //title
              Center(
                child: Text('إرسال نقاط', style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w900,
                  fontSize: 15
                ),),
              ),

              SizedBox(height: 15,),

              //directions
              Center(
                child: Text('أدخل عدد النقاط المراد إرسالها إلى', style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
              ),

              SizedBox(height: 15,),

              //name of family member
              Center(
                child: Text(documentSnapshot!.get('name'), style: TextStyle(
                    color: kPrimaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
              ),

              SizedBox(height: 20,),

              TextFieldDesign.plainTextFieldStyle(
                context, 
                controller: _pointsController, 
                kbType: TextInputType.numberWithOptions(decimal: true),
                validat: (value) {
                  if (value.isEmpty) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                }
              ),

              SizedBox(height: 20),

              Center(
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
                  child: const Text( 'إرسال', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // fontSize:
                  ),),
                  onPressed: () async {
                    final int? points = int.parse(_pointsController.text);
                    if (points != null) {

                        await _members
                            .doc(documentSnapshot.id)
                            .update({"points": points});
                            
                      _pointsController.text = '';
                        Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          ),
        );
      }
    );
  
  }

  //delete member method 
  Future<void> _deleteMember([DocumentSnapshot? documentSnapshot]) async {

    final String? memberId = documentSnapshot?.id;

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //cancel icon button 
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kPrimaryGreen)
                    ),
                    child: IconButton(
                      iconSize: 35,
                      onPressed: (() => Navigator.pop(context)), 
                      icon: Transform.rotate(
                        angle: 45 * pi / 180,
                        child: Icon(Icons.add, 
                          color: kPrimaryGreen,)
                          ),
                        ),
                  ),
                ],
              ),

              //title
              Center(
                child: Text('حذف فرد من العائلة', style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w900,
                  fontSize: 15
                ),),
              ),

              SizedBox(height: 25,),

              //directions
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('هل تريد حذف', style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),),
                    ),
              
                    SizedBox(width: 10,),
              
                    //name of family member
                    Center(
                      child: Text(documentSnapshot!.get('name'), style: TextStyle(
                          color: kPrimaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              
              Center(
                child: Text('ملاحظة:  جميع نقاط الشخص سيتم تحويلها إليك',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15
                ),),
              ),

              SizedBox(height: 35),

              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width*0.4, 
                      MediaQuery.of(context).size.height*0.055
                    ),
                    backgroundColor: kSecondaryOrange,
                  ),
                  child: const Text( 'إرسال', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // fontSize:
                  ),),
                  onPressed: () async {

                      await _members.doc(memberId).delete();

                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم حذف الفرد بنجاح'),
                        duration: Duration(seconds: 2),
                      )
                    );
                            
                    _pointsController.text = '';
                      Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> _addMember() async {

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //cancel icon button 
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kPrimaryGreen)
                    ),
                    child: IconButton(
                      iconSize: 35,
                      onPressed: (() => Navigator.pop(context)), 
                      icon: Transform.rotate(
                        angle: 45 * pi / 180,
                        child: Icon(Icons.add, 
                          color: kPrimaryGreen,)
                          ),
                        ),
                  ),
                ],
              ),

              //directions
              Center(
                child: Text('أدخل رقم جوال فرد العائلة لدعوته', style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
              ),

              SizedBox(height: 40,),

              TextFieldDesign.plainTextFieldStyle(
                context, 
                controller: _phoneController, 
                kbType: TextInputType.numberWithOptions(decimal: true),
                validat: (value) {
                  //TODO: validate if less than 10 digits
                  if (value.isEmpty) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                },
                htTxt: '05XXXXXXXX'
              ),

              SizedBox(height: 20),

              Center(
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
                  child: const Text( 'إرسال', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // fontSize:
                  ),),
                  onPressed: () async {
                    if (_phoneController.text != null) {

                      //Declaring variables for users' info
                      final String inputPhone = _phoneController.text.trim();
                      String invitedPhone;
                      String invitedName;
                      String invitedUID;
                      num invitedPoints;

                      //inviter info
                      String inviterUID;
                      String inviterName; 
                      String inviterPhone;
                      num inviterPoints;
                      User? user = FirebaseAuth.instance.currentUser;
                      String currrentUserUID = user!.uid;

                      final querySnapshot = await _users
                      .where('phone', isEqualTo: inputPhone)
                      .get();

                      final Map<String, dynamic> userData = querySnapshot.docs.first.data() as Map<String, dynamic>;


                      final querySnapshotCurrent = await _users
                      .where('uid', isEqualTo: currrentUserUID)
                      .get();

                      final Map<String, dynamic> currentUserData = querySnapshotCurrent.docs.first.data() as Map<String, dynamic>;

                      print(userData['firstName']);

                      //invited info
                      invitedPhone = userData['phone'];
                      invitedName = userData['firstName'] + userData['lastName'];
                      invitedUID = userData['uid'];
                      invitedPoints = userData['points'];

                      print('phone number is: $invitedPhone and name is $invitedName');

                      //inviter info
                      inviterPhone = currentUserData['phone'];
                      inviterName = currentUserData['firstName'] + currentUserData['lastName'];
                      inviterUID = currentUserData['uid'];
                      inviterPoints = currentUserData['points'];

                      print('inviter phone is: $inviterPhone and inviter name: $inviterName');


                      if (invitedPhone != null ) {
                        //add invitee to the outgoing invited collection of inviter
                        await _invited.doc(currrentUserUID)
                        .set({'name': invitedName, 'phone': invitedPhone, 'points': invitedPoints})
                        .then((_) => print('Added to invited list'))
                        .catchError((error) => print('Add failed: $error'));

                        // add inviter to the incoming invites collection of invitee
                        await _invites.doc(invitedUID)
                        .set({'name': inviterName, 'phone': inviterPhone, 'points': inviterPoints})
                        .then((_) => print('Added to invites list'))
                        .catchError((error) => print('Add failed: $error'));
                      }

                      // for (var doc in querySnapshot.docs) {

                      //   //invited info
                      //   invitedName = doc.get('firstName') + doc.get('lastName');
                      //   invitedPhone = doc.get('phone');
                      //   invitedPoints = doc.get('points');
                      //   invitedUID = doc.get('uid');

                      //   print('phone number is: $invitedPhone and name is $invitedName');
                      // }

                      // DocumentSnapshot snapshot = FirebaseFirestore.instance.collection('users').doc(user?.uid).get() as DocumentSnapshot;


                      // for (var doc in querySnapshotCurrent.docs) {

                      //   //inviter info
                      //   inviterName = doc.get('firstName') + doc.get('lastName');
                      //   inviterPhone = doc.get('phone');
                      //   inviterPoints = doc.get('points');
                      //   inviterUID = doc.get('uid');

                      //   print('inviter phone: $inviterPhone, name: $inviterName, uid: ' + currrentUserUID);

                      // }










                      // if (invitedPhone != null ) {
                      //   //add invitee to the outgoing invited collection of inviter
                      //   await _invited.doc(user?.uid)
                      //   .set({'name': invitedName, 'phone': invitedPhone, 'points': invitedPoints})
                      //   .then((_) => print('Added to invited list'))
                      //   .catchError((error) => print('Add failed: $error'));

                      //   // add inviter to the incoming invites collection of invitee
                      //   await _invites.doc(invitedUID)
                      //   .set({'name': inviterName, 'phone': inviterPhone, 'points': inviterPoints})
                      //   .then((_) => print('Added to invites list'))
                      //   .catchError((error) => print('Add failed: $error'));
                      // }
                            
                      _phoneController.text = '';
                        Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('لا يوجد فرد مسجل بهذا الرقم'),
                          duration: Duration(seconds: 2),
                        )
                      );
                    }
                  },
                ),
              )
            ],
          ),
        );
      }
    );
  
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double scWidth = size.width;
    double scHeight = size.height;

    // int invitesNo = getInvites();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: scHeight*0.07,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30) 
              ), 
            ),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(height: 20,),
            
                //My Family title
                Text('عائلتي', style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),),
            
                StreamBuilder(
                  stream: _members.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)  { 
                    //TODO: try != null instead of hasData
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          final DocumentSnapshot documentSnapshot = 
                            streamSnapshot.data!.docs[index];
                          final String name = documentSnapshot['name'];
                          final String phone = documentSnapshot['phone'];
                          final num points = documentSnapshot['points'];
                          final num invites = documentSnapshot['invites'];
                
                          return memberCard(
                            context, 
                            name, 
                            points,
                            (() => _addPoints(documentSnapshot)),
                            (() => _deleteMember(documentSnapshot))
                          );
                        }),
                      );
                    }
                    print(streamSnapshot.hasData);
                
                    //in case no members were added
                    return Container(
                      margin: EdgeInsets.only(top: scHeight*0.08),
                      height: 30,
                      child: Text('لم تقم بإضافة أي فرد عائلة', 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16
                        ),
                      ),
                    );
                  }
                ),

                // Container(
                //       margin: EdgeInsets.only(top: scHeight*0.08),
                //       height: 30,
                //       child: Text('لم تقم بإضافة أي فرد عائلة', 
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //           color: Colors.black38,
                //           fontSize: 16
                //         ),
                //       ),
                //     ),

                SizedBox(height: scHeight*0.04,),

                //add member of family
                Center(
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
                    child: const Text( 'إضافة فرد من العائلة', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      // fontSize:
                    ),),
                    onPressed: () {
                      _addMember();
                    },
                  ),
                ),
      
                SizedBox(height: 10,),


                Center(
                  // child: Text('لديك ($invitesNo) دعوات', style: TextStyle(
                    // color: Colors.grey[500],
                  // ),),
                ),
            
              ],
            ),
          )
        ],
      ),
    );
  }
}