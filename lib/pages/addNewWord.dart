/*
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:motivatiup/models/databaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class AddNewWord extends StatefulWidget {
  @override
  _AddNewWordState createState() => _AddNewWordState();
}

const Color mainColor = Colors.deepPurple;
const Color secColor = Colors.orange;

int vID;
String vSoz;
String vSozSoyleyen = null;
String vCategory = null;
bool vFavori = false;

class _AddNewWordState extends State<AddNewWord> {
  final formKey = GlobalKey<FormState>();
  final databaseHelper = DatabaseHelper.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Motivasyon sözü ekle';
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
        backgroundColor: secColor.withAlpha(100),
        elevation: 0,
      ),
      body: Main(),
    );
  }

  Widget Main() {
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
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: CreateForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CreateForm() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 2,
            autofocus: false,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              color: Colors.grey[900],
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
              hintText: 'bir motivasyon sözü',
              labelText: 'Motivasyon sözü',
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22.0,
                color: Colors.grey[900],
                fontWeight: FontWeight.w500,
              ),
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.0,
                color: Colors.grey[700],
                fontWeight: FontWeight.w300,
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Lütfen bir söz yazınız.';
              }
              setState(() {
                vSoz = value;
                print(vSoz);
              });
            },
            onSaved: (String yazilanVeri) {
              setState(() {
                vSoz = yazilanVeri;
                print(vSoz);
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              color: Colors.grey[900],
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
              hintText: 'motivasyon sözünü söyleyen kişi',
              labelText: 'Söz sahibi',
              helperText: 'gerekli değil',
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20.0,
                color: Colors.grey[900],
                fontWeight: FontWeight.w300,
              ),
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.0,
                color: Colors.grey[700],
                fontWeight: FontWeight.w300,
              ),
            ),
            validator: (value) {
              setState(() {
                vSozSoyleyen = value;
                print(vSozSoyleyen);
              });
            },
            onSaved: (String yazilanVeri) {
              setState(() {
                vSozSoyleyen = yazilanVeri;
                print(vSozSoyleyen);
              });
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            onPressed: () {
              _insert();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffFF5F6D), Color(0xffFFC371)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints:
                    BoxConstraints(maxWidth: double.infinity, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  "Kayıt ekle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 19.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showDalog() {
    return AlertDialog(
      title: Text("Deneme"),
      content: Container(
        width: double.infinity,
        child: Text("içerik"),
      ),
    );
  }

  void _insert() async {
    if (formKey.currentState.validate() == true) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnQuote: vSoz,
        DatabaseHelper.columnQuoteOwner: vSozSoyleyen
      };
      final id = await databaseHelper.insert(row);
      print("$id ,'li öğe başarıyla eklendi.");

      print(vSoz);
      print(vSozSoyleyen);
    } else {
      print("Veri kaydı yapılırken bir hata oluştu.");
    }
  }

  // verileri listeleme methodu
  void _query() async {
    final allRows = await databaseHelper.queryAllRows();
    print("tüm datalar getirildi.");
    allRows.forEach((row) {
      print(row);
    });
  }

  // güncelleme methodu
  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: vID,
      DatabaseHelper.columnQuote: vSoz,
      DatabaseHelper.columnQuoteOwner: vSozSoyleyen,
      DatabaseHelper.columnCategory: vCategory,
      DatabaseHelper.isFavorited: vFavori
    };
    final updatedRows = await databaseHelper.update(row);
    print("$updatedRows güncellendi.");
  }

  void _delete() async {
    final rowsDeleted = await databaseHelper.delete(vID);
    print("$rowsDeleted id'li veri silindi.");
  }
}

*/
