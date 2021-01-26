import 'package:PLANTIFY/navbar.dart';
import 'package:PLANTIFY/screens/home/Newplant.dart';
import 'package:PLANTIFY/screens/myplant.dart';
import 'package:PLANTIFY/screens/nurture.dart';
import 'package:PLANTIFY/screens/plantpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

Color backgroundColor = Color.fromRGBO(130, 205, 113, 1);

class _MainWidgetState extends State<MainWidget> {
  int _selectedTab = 0;
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List values = [Newplant(), Myplant(), Nurture(), Plantpay()];
    List<Color> colors = [
      backgroundColor,
      backgroundColor,
      backgroundColor,
      backgroundColor
    ];
    PageController controller = PageController();
    void _handleIndexChanged(int i) {
      setState(() {
        _selectedTab = i;
        controller.jumpToPage(i);
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: colors.length,
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                print(value);
                _selectedTab = value;
              });
            },
            itemBuilder: (context, index) {
              return values[index];
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: DotNavigationBar(
                currentIndex: _selectedTab,
                onTap: _handleIndexChanged,
                items: [
                  /// Home
                  DotNavigationBarItem(
                      icon: 'assets/ns.png', name: 'NEW PLANT'),

                  /// Likes
                  DotNavigationBarItem(
                      icon: 'assets/np.png', name: 'MY PLANTS'),

                  /// Search
                  DotNavigationBarItem(icon: 'assets/nw.png', name: 'NURTURE'),

                  /// Profile
                  DotNavigationBarItem(
                      icon: 'assets/PB.png', name: 'PLANT BANK'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
