import 'dart:math';

import 'package:flutter/material.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';

Widget inviteCard(context, name, phone, accept(), reject()) {
  return ListTile(
    title: Center(
      child: Container(
        width: MediaQuery.of(context).size.width*1,
        height: MediaQuery.of(context).size.height*0.09,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [        
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(name, style: TextStyle(
                    fontSize: 18,
                    color: kPrimaryGreen,
                  ),), 
                  Text(phone, style: TextStyle(
                    fontSize: 17,
                    color: Colors.black45,
                  ),)
                ],
              ),
        
        
              //add and delete buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Add points to member button
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryGreen),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: IconButton(
                      iconSize: 25,
                      onPressed: () {
                        accept();
                      }, 
                      icon: Transform.rotate(
                        angle: 45 * pi / 180,
                        child: const Icon(Icons.add, 
                        color: kSecondaryOrange,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8,),

                  //Delete member button
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kSecondaryOrange),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: IconButton(
                      iconSize: 25,
                      onPressed: () {
                        reject();
                      }, 
                      icon: const Icon(Icons.done, 
                      color: kPrimaryGreen,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}