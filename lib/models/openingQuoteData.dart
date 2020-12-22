class QuoteData {
  int id;
  String quoteWord;
  String quoteWordOwner;
  String quoteCategory;
  int isFavorited;

  QuoteData(this.id, this.quoteWord, this.quoteWordOwner, this.quoteCategory,
      this.isFavorited);
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'quote': quoteWord,
      'quoteOwner': quoteWordOwner,
      'quoteCategory': quoteCategory,
      'isFavorited': isFavorited,
    };
  }

  Map<String, dynamic> toMap2(QuoteData map) {
    return {
      '_id': map.id,
      'quote': map.quoteWord,
      'quoteOwner': map.quoteWordOwner,
      'quoteCategory': map.quoteCategory,
      'isFavorited': map.isFavorited,
    };
  }
}
