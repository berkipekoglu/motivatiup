import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bd_progress_bar/bdprogreebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivatiup/data/api/motivatiupModels.dart';
import 'package:motivatiup/models/databaseHelper.dart';
import 'package:motivatiup/models/openingQuoteData.dart';
import 'package:motivatiup/pages/favoritesPage.dart';
import 'package:motivatiup/pages/notificationPage.dart';
import 'package:motivatiup/pages/addNewWord.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<dynamic> getRandomOneQuoteMethod() async {
  return await DatabaseHelper().getOneRandomQuote();
}

const Color mainColor = Colors.deepPurple;
const Color secColor = Colors.orange;
int _selectedNavBarItem = 0;
int _itemCount;

int quoteCount;
int categoryCount;
int randomNumber;
QuoteData quoteData;

class _HomeScreenState extends State<HomeScreen> {
  int randomNumber;
  List<Widget> allPages = [];
  NotificationSettingsPage _notificationSettingsPage;
  FavoritesPage _favoritesPage;
  var databaseHelper;
  @override
  void initState() {
    super.initState();

    _notificationSettingsPage = NotificationSettingsPage();
    _favoritesPage = FavoritesPage();
    allPages = [
      Body(),
      _favoritesPage,
      _notificationSettingsPage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secColor.withAlpha(100),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          /*
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 27,
                      ),
                      onPressed: () {},
                    ),
                    */
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Row(
              children: [
                Text(
                  "Motivatiup",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: allPages[_selectedNavBarItem],
      bottomNavigationBar: BottomNavigationBarMethod(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: mainColor,
        elevation: 5.0,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => null) //AddNewWord()),
              );
        },
      ),
    );
  }

  BottomNavigationBarMethod() {
    return BottomNavigationBar(
      elevation: 0.0,
      backgroundColor: mainColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 34,
      currentIndex: _selectedNavBarItem,
      onTap: (index) {
        setState(() {
          _selectedNavBarItem = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Anasayfa",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Shuffle",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active),
          label: "Bildirimler",
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: MainBody(),
        ),
      ),
    );
  }
}

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          quoteData = QuoteData(
              snapshot.data['_id'],
              snapshot.data['quoteWord'],
              snapshot.data['quoteWordOwner'],
              snapshot.data['quoteCategory'],
              snapshot.data['isFavorited']);
          print("FUTUREBUİLDER " + quoteData.isFavorited.toString());
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  right: 30,
                  left: 30,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 30, left: 30, bottom: 10),
                      child: AutoSizeText(
                        //"After climbing, a great hill, one finds that there are many more hills to climb.",
                        quoteData.quoteWord,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 24.0,
                          letterSpacing: 0.7,
                        ),
                        textAlign: TextAlign.center,
                        minFontSize: 16,
                        stepGranularity: 2,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 30, left: 30, top: 5),
                      child: AutoSizeText(
                        "- ${quoteData.quoteWordOwner}",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[750],
                          fontSize: 18.0,
                          letterSpacing: 0.7,
                        ),
                        textAlign: TextAlign.center,
                        minFontSize: 16,
                        stepGranularity: 1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // favorite button
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: MainBodyButtons(),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        // shuffle button
                        _buildShuffleButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          print("İnceleniyor..");
          return Loader(
            colors: Colors.pinkAccent.withAlpha(100),
            backColors: mainColor.withAlpha(100),
          );
        }
      },
      future: getRandomOneQuoteMethod(),
    );
  }

  Future<QuoteData> randomQuote() async {
    Map<String, dynamic> map = await DatabaseHelper().getOneRandomQuote();
    QuoteData quoteData = QuoteData(map['_id'], map['quoteWord'],
        map['quoteWordOwner'], map['quoteCategory'], map['isFavorited']);
    return quoteData;
  }

  Container _buildShuffleButton() {
    return Container(
      child: Column(
        children: [
          IconButton(
            icon: Icon(
              Icons.shuffle,
              color: Color(0xff4a4e69),
            ),
            onPressed: () {
              setState(() {
                randomQuote();
              });

              debugPrint("değiştirildi");
            },
            iconSize: 35,
          ),
          Text(
            "Değiştir",
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
              color: Color(0xff4a4e69),
            ),
          ),
        ],
      ),
    );
  }
}

class MainBodyButtons extends StatefulWidget {
  @override
  _MainBodyButtonsState createState() => _MainBodyButtonsState();
}

class _MainBodyButtonsState extends State<MainBodyButtons> {
  @override
  Widget build(BuildContext context) {
    return buildFavoritedButton();
  }

  void _update() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    print('ALINAN DEĞERLER ' +
        quoteData.id.toString() +
        quoteData.quoteWord.toString() +
        quoteData.isFavorited.toString());
    Map<String, dynamic> row = {
      '_id': quoteData.id,
      'quoteWord': quoteData.quoteWord,
      'quoteWordOwner': quoteData.quoteWordOwner,
      'quoteCategory': quoteData.quoteCategory,
      'isFavorited': quoteData.isFavorited
    };
    final rowsAffected = await databaseHelper.updateQuote(row);
    print('updated $rowsAffected row(s)');
  }

  _favoritedControl() {
    setState(() {
      if (quoteData.isFavorited == 1) {
        quoteData.isFavorited = 0;
        _update();
        debugPrint("Favorilerden çıkarıldı.");
      } else {
        quoteData.isFavorited = 1;
        _update();
        debugPrint("Favorilere eklendi.");
      }
    });
    print(quoteData.isFavorited);
    print(quoteData.quoteWord);
  }

  Container buildFavoritedButton() {
    return Container(
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              _favoritedControl();
            },
            icon: Icon(
                quoteData.isFavorited == 1
                    ? Icons.favorite_outlined
                    : Icons.favorite_border_outlined,
                color: quoteData.isFavorited == 1
                    ? Color(0xffff0a54)
                    : Color(0xff4a4e69),
                size: 30),
          ),
          Text(
            quoteData.isFavorited == 1 ? "Beğenildi" : "Beğen",
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
              color: quoteData.isFavorited == 1
                  ? Color(0xffff0a54)
                  : Color(0xff4a4e69),
            ),
          ),
        ],
      ),
    );
  }
}
