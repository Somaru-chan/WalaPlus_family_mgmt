import 'package:flutter/material.dart';
import 'package:walaplus_family_mgmt/constants/colors.dart';
import 'package:walaplus_family_mgmt/ui/home.dart';
import 'package:walaplus_family_mgmt/ui/points.dart';
import 'package:walaplus_family_mgmt/ui/invites.dart';
import 'package:walaplus_family_mgmt/ui/qr_code.dart';
import 'package:walaplus_family_mgmt/ui/search.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({ Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int currentTab = 1;

  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> screens = [
    HomeScreen(),
    PointsScreen(),
    QRCodeScreen(),
    SearchScreen(),
    InvitesScreen()
  ];

  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          backgroundColor: kPrimaryGreen,
          heroTag: 'QRFAB',
          child: const Icon(Icons.qr_code_scanner_rounded, size: 32,),
          onPressed: () {
            setState(() {
              currentScreen = QRCodeScreen();
              currentTab = 2;
            });
          },
          elevation: 0.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Left tab bar icons
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 10,
                    onPressed: () {
                      setState(() {
                        currentScreen = InvitesScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          color: currentTab == 0 
                          ? kPrimaryGreen 
                          : Colors.grey[300],
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = SearchScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.scatter_plot_outlined,
                          color: currentTab == 4 
                          ? kPrimaryGreen 
                          : Colors.grey[300],
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //Right tab bar icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Left tab bar icons
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = PointsScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: currentTab == 3 
                          ? kPrimaryGreen 
                          : Colors.grey[300],
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: currentTab == 1 
                          ? kPrimaryGreen 
                          : Colors.grey[300],
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}