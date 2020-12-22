import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/homeScreen.dart';

class SplashScreenEkrani extends StatefulWidget {
  @override
  _SplashScreenEkraniState createState() => _SplashScreenEkraniState();
}

class _SplashScreenEkraniState extends State<SplashScreenEkrani> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TODO: implement initState

    Timer(
      Duration(seconds: 5),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen())),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/way.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Logo(),
              //Image(image: AssetImage("assets/images/splash-logo.png"),),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hayal et.",
                    style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        inherit: false),
                  ),
                  Text(
                    "İnan.",
                    style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        inherit: false),
                  ),
                  Text(
                    "Yap.",
                    style: TextStyle(
                        fontSize: 35.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        inherit: false),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Motivatiup Inc.",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.7),
                          inherit: false),
                    ),
                    ClipRRect(
                      child: Material(
                        color: Colors.black.withOpacity(0),
                        child: InkWell(
                          focusColor: Colors.deepPurple,
                          autofocus: true,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20.0,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.solid,
          width: 10.0,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Mo",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),
          Text(
            "ti",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),
          Text(
            "va",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),
          Text(
            "ti",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),
          Text(
            "up",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 40.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.none),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
