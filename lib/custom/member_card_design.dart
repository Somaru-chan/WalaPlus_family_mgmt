import 'package:flutter/material.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';

Widget memberCard(context, name, points, addPoints(), deleteMember()) {
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
              Text(name, style: TextStyle(
                color: Colors.black54,
                fontSize: 18
              ),),
        
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(points.toString(), style: TextStyle(
                    fontSize: 24,
                    color: kPrimaryGreen,
                  ),), 
                  const Text('نقطة', style: TextStyle(
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
                        addPoints();
                      }, 
                      icon: const Icon(Icons.add, 
                      color: kPrimaryGreen,
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
                        deleteMember();
                      }, 
                      icon: const Icon(Icons.delete_outline_rounded, 
                      color: kSecondaryOrange,
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