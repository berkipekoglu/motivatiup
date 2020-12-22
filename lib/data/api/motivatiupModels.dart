import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:motivatiup/pages/homeScreen.dart';

class MotivatiupQuteModels {
  List quotes;
  List categories;

  MotivatiupQuteModels({this.quotes, this.categories});

  factory MotivatiupQuteModels.fromJson(Map<String, dynamic> list) {
    return MotivatiupQuteModels(
      quotes: list["quotes"],
      categories: list["categories"],
    );
  }

  Future<Map<String, dynamic>> toJson(
      MotivatiupQuteModels motivatiupQuteModels) async {
    Map<String, dynamic> veriler = motivatiupQuteModels.quotes[0] = {
      'id': 1,
      'quote': 'Bunu da başardık!',
      'quoteOwner': "Berk İpekoğlu",
      'quoteCategory': "Success",
      'isFavorited': false
    };
    String jsonString =
        await rootBundle.loadString('assets/data/motivatiup.json');

    print(jsonString);
  }
}

class QuoteMap {
  int id;
  String quote;
  String quoteOwner;
  String quoteCategory;
  bool isFavorited;

  QuoteMap({
    this.id,
    this.quote,
    this.quoteOwner,
    this.quoteCategory,
    this.isFavorited,
  });

  factory QuoteMap.fromMap(Map<String, dynamic> map) {
    return QuoteMap(
      id: map['id'],
      quote: map['quote'],
      quoteOwner: map['quoteOwner'],
      quoteCategory: map['quoteCategory'],
      isFavorited: map['isFavorited'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'quoteOwner': quoteOwner,
      'quoteCategory': quoteCategory,
      'isFavorited': isFavorited,
    };
  }

  printAll() {
    print('ID: ' + id.toString());
    print('Quote: ' + quote);
    print('Quote owner: ' + quoteOwner);
    print('Quote category: ' + quoteCategory);
    print('Is favorited?: ' + isFavorited.toString());
  }
}

class CategoryMap {
  int categoryId;
  String categoryName;

  CategoryMap({
    this.categoryId,
    this.categoryName,
  });

  factory CategoryMap.fromMap(Map<String, dynamic> map) {
    return CategoryMap(
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
    );
  }

  printAll() {
    print('Kategori id: ' + categoryId.toString());
    print('Kategori adı: ' + categoryName);
  }
}
