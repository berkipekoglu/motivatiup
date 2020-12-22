import 'dart:async';
import 'package:bd_progress_bar/bdprogreebar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motivatiup/models/databaseHelper.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

const Color mainColor = Colors.deepPurple;
const Color secColor = Colors.orange;
const favorilerColorPink = Color(0xffff0a54);
const favorilerColorBej = Color(0xffffd09e);
const favorilerColorPurple = Color(0xff4e0250);

DatabaseHelper databaseHelper = DatabaseHelper();

class _FavoritesPageState extends State<FavoritesPage> {
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
          child: SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(right: 30, left: 30, bottom: 20, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 7.0),
                    child: Text(
                      "Favoriler",
                      style: TextStyle(
                        fontSize: 27.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: favorilerColorPink,
                      ),
                    ),
                  ),
                  FutureBody(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FutureBody extends StatefulWidget {
  @override
  _FutureBodyState createState() => _FutureBodyState();
}

class _FutureBodyState extends State<FutureBody> {
  Future<List<Quotes>> getQuotes() async {
    List<Map<String, dynamic>> data = await DatabaseHelper().likedQuotes();
    List<Quotes> quotes = [];
    for (var i in data) {
      Quotes quote = Quotes(i['_id'], i['quoteWord'], i['quoteWordOwner'],
          i['quoteCategory'], i['isFavorited']);

      quotes.add(quote);
    }
    return quotes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getQuotes(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Loader(
                colors: Colors.pinkAccent.withAlpha(100),
                backColors: mainColor.withAlpha(100),
              ),
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(7.0),
                    minVerticalPadding: 5.0,
                    title: Text(
                      snapshot.data[index].quoteWord,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Color(0xff403647).withAlpha(210),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        int id = snapshot.data[index].id;
                        _unFavorited(id);
                      },
                      icon: Icon(
                          snapshot.data[index].isFavorited == 1
                              ? Icons.favorite_outlined
                              : Icons.favorite_border_outlined,
                          color: Color(0xffeae3d9),
                          size: 30),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        snapshot.data[index].quoteCategory,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0,
                          color: Color(0xff403647).withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          );
        }
      },
    );
  }

  void _unFavorited(int id) {
    setState(() {
      databaseHelper.idUpdate(id);
    });
    Fluttertoast.showToast(
      msg: 'Favorilerden çıkarıldı.',
      backgroundColor: Color(0xff22223b),
    );
    //Timer(Duration(seconds: 3), () {setState(() {});});
  }
}

class Quotes {
  int id;
  String quoteWord;
  String quoteWordOwner;
  String quoteCategory;
  int isFavorited;

  Quotes(this.id, this.quoteWord, this.quoteWordOwner, this.quoteCategory,
      this.isFavorited);
}
