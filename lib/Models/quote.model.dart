class Quote {
  final String quote;

  Quote({
    this.quote,
  });

  factory Quote.fromJson(String json) {
    return Quote(quote: json);
  }
}
