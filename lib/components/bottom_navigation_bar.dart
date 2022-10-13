import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:ug_blood_donate/screens/Blood_group_stat.dart';
import 'package:ug_blood_donate/screens/create_event.dart';
import 'package:ug_blood_donate/screens/first_screens/blood_page.dart';
import 'package:ug_blood_donate/screens/updateHistory.dart';
import 'package:ug_blood_donate/screens/user_req.dart';

import '../screens/map/Doctor_profile.dart';

class BaseBar extends StatelessWidget {
  const BaseBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 182, 2, 2),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final _bottomBarController = BottomBarWithSheetController(initialIndex: 0);
  final screens = [
    const Request_page(),
    const CreateEvent(),
    UserNotification(),
    ProfilePage(),
    // const HistoryScanner(),
  ];
  @override
  void initState() {
    _bottomBarController.stream.listen((opened) {
      debugPrint('Bottom bar ${opened ? 'opened' : 'closed'}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 182, 2, 2),
      body: screens[index],
      bottomNavigationBar: BottomBarWithSheet(
        controller: _bottomBarController,
        bottomBarTheme: const BottomBarTheme(
          mainButtonPosition: MainButtonPosition.middle,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          itemIconColor: Colors.grey,
          itemTextStyle: TextStyle(
            color: Colors.grey,
            fontSize: 10.0,
          ),
          selectedItemTextStyle: TextStyle(
            color: Color.fromARGB(255, 182, 2, 2),
            fontSize: 10.0,
          ),
        ),
        onSelectItem: (index) {
          setState(() {
            this.index = index;
          });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => RightButtonExample(),
          //   ),
          // );
        }, //debugPrint('$index'),
        sheetChild: Column(children: [
          Text(
            "Another content",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return B_G_stat();
                  }),
                );
              },
              child: Text(
                "Blood stat:",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const HistoryScanner();
                  }),
                );
              },
              child: Text(
                "History :",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ]),
        items: const [
          BottomBarWithSheetItem(icon: Icons.home),
          BottomBarWithSheetItem(icon: Icons.create_new_folder),
          BottomBarWithSheetItem(icon: Icons.circle_notifications),
          BottomBarWithSheetItem(icon: Icons.person),
        ],
      ),
    );
  }
}
