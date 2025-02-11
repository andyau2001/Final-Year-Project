import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/NumberPad/InputPassword.dart';
import 'package:new_app/NumberPad/InsertAmount.dart';
import 'package:new_app/Page/HistoryPage.dart';
import 'package:new_app/Page/HomePage.dart';
import 'package:new_app/Page/PayPage.dart';
import 'package:new_app/Page/ProfilePage.dart';
import 'package:new_app/Page/QRPayPage.dart';
import 'package:new_app/Page/WalletPage.dart';

class HomeScreen extends StatefulWidget{
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    WalletPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.qr_code),
        backgroundColor: Color(0xffFCB800),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PayPage()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: currentTab == 0 ? Color(0xffFCB800) : Color(0xff000000),
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color:currentTab == 0 ? Color(0xffFCB800) : Color(0xff000000),
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = WalletPage();
                        currentTab = 1;
                      });
                    },
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wallet,
                          color: currentTab == 1 ? Color(0xffFCB800) : Color(0xff000000),
                        ),
                        Text(
                          'Wallet',
                          style: TextStyle(
                            color:currentTab == 1 ? Color(0xffFCB800) : Color(0xff000000),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              //Right Tab Bar Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = HistoryPage();
                        currentTab = 2;
                      });
                    },
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          color: currentTab == 2 ? Color(0xffFCB800) : Color(0xff000000),
                        ),
                        Text(
                          'History',
                          style: TextStyle(
                            color:currentTab == 2 ? Color(0xffFCB800) : Color(0xff000000),
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen = ProfilePage();
                        currentTab = 3;
                      });
                    },
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? Color(0xffFCB800) : Color(0xff000000),
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color:currentTab == 3 ? Color(0xffFCB800) : Color(0xff000000),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ]
          ),
        )
      )
    );
  }
}
