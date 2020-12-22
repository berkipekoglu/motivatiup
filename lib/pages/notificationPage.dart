import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

const Color mainColor = Colors.deepPurple;
const Color secColor = Colors.orange;

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPageTemplate(),
    );
  }

  MainPageTemplate() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            secColor.withAlpha(100),
            mainColor,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0, top: 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Bildirimleri kapat/aç",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Bildirimler her dakikada bir gelecektir.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              OnOffSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}

class OnOffSwitch extends StatefulWidget {
  @override
  _OnOffSwitchState createState() => _OnOffSwitchState();
}

class _OnOffSwitchState extends State<OnOffSwitch>
    with SingleTickerProviderStateMixin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isChecked = false;
  Duration _duration = Duration(milliseconds: 370);
  Animation<Alignment> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var androidInitialize = AndroidInitializationSettings('motivatiup_m_black');
    var iOsInitialize = IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOsInitialize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: notificationSelected);

    _animationController =
        AnimationController(vsync: this, duration: _duration);

    _animation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "Channel ID", "Channel Name", "Channel Description",
        importance: Importance.max);
    var iOSDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    // await flutterLocalNotificationsPlugin.show(
    //     0, "Tast", "Body", generalNotificationDetails,
    //    payload: "Payload ile Gönderilen Veri");

    // planlanmış bildiri
    /*
    var scheduledTime = DateTime.now().add(Duration(seconds: 4));

    flutterLocalNotificationsPlugin.schedule(1, "Başlık", "Bildirim içeriği",
        scheduledTime, generalNotificationDetails);
    */

    flutterLocalNotificationsPlugin.periodicallyShow(
        1,
        "Başlık",
        "Bildirim içeriği",
        RepeatInterval.everyMinute,
        generalNotificationDetails);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked after screen $payload"),
      ),
    );
  }

  Future _cancelAllNotification() async {
    print("Bildirimler kapatıldı");
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 110,
          height: 50,
          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
          decoration: BoxDecoration(
              color: isChecked ? Colors.green : Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                    color: isChecked ? Colors.green : Colors.red,
                    blurRadius: 12,
                    offset: Offset(0, 8))
              ]),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: _animation.value,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_animationController.isCompleted) {
                        _cancelAllNotification();
                        _animationController.reverse();
                        print("Switch reverse oldu");
                      } else {
                        _showNotification();
                        _animationController.forward();
                        print("Switch forward oldu");
                      }
                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
