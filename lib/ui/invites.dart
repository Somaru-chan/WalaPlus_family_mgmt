import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:walaplus_family_mgmt/custom/invite_card_design.dart';

class InvitesScreen extends StatefulWidget {
  const InvitesScreen({ Key? key }) : super(key: key);

  @override
  State<InvitesScreen> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InvitesScreen> {

  final CollectionReference _invites = 
  FirebaseFirestore.instance.collection('invites');

  final CollectionReference _members = 
  FirebaseFirestore.instance.collection('members');

  Future<void> _accept([DocumentSnapshot? documentSnapshot]) async {

    final String name = documentSnapshot!.get('name');
    final String phone = documentSnapshot.get('phone');
    final num points = documentSnapshot.get('points');

    await _members.add({'name': name, 'phone': phone, 'points': points});

    // await _invites.doc().delete();
  }

  Future<void> _reject([DocumentSnapshot? documentSnapshot]) async {

    final String name = documentSnapshot!.get('name');
    final String phone = documentSnapshot.get('phone');
    final num points = documentSnapshot.get('points');

    await _invites.doc().delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: StreamBuilder(
      //   stream: _invites.snapshots(), 
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> streamSnapshot) { 
      //     if(streamSnapshot.hasError) {
      //       return Center(
      //         child: Text('No new invites')
      //       );
      //     }
      //     return ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: streamSnapshot.data!.docs.length,
      //       itemBuilder: ((context, index) {
      //         final DocumentSnapshot documentSnapshot = 
      //           streamSnapshot.data!.docs[index];
    
      //         return inviteCard(
      //           context, 
      //           name, 
      //           phone,
      //           (() => _accept(documentSnapshot)),
      //           (() => _reject(documentSnapshot))
      //         );
      //       }),
      //     );
      //   },
      // ),
    );
  }
}