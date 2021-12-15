import 'dart:ui';

import 'package:a_m_shop_app/on_boarding/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/besho/AndroidStudioProjects/a_m_shop_app/lib/shop_screens/login_screen.dart';

class BoardingScreen {
  String image;
  String title;
  String body;

  BoardingScreen(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();

  bool isLast = false;

  List<BoardingScreen> boardingList = [
    BoardingScreen('assets/images/smokingman.png', 'title 1', 'body 1'),
    BoardingScreen('assets/images/smokingman.png', 'title 2', 'body 2'),
    BoardingScreen('assets/images/smokingman.png', 'title 3', 'body 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                setOnBoardingSeen();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
              child: Text('Skip',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent)))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: PageView.builder(
                onPageChanged: (int pagesNumber) {
                  if (pagesNumber == boardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  }
                },
                controller: pageController,
                itemCount: boardingList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Image(
                          image: AssetImage('${boardingList[index].image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Text(
                        '${boardingList[index].title}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        '${boardingList[index].body}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'data',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                    ),
                    Spacer(),
                    FloatingActionButton(
                      backgroundColor: Colors.deepOrangeAccent,
                      onPressed: () {
                        if (isLast) {
                          setOnBoardingSeen();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        } else
                          pageController.nextPage(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn);
                      },
                      child: Icon(Icons.arrow_right),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  setOnBoardingSeen() async {
    await SharedPrefShop.putData('onBoarding3', true);
  }
}
