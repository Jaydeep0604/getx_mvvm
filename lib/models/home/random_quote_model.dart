import 'package:getx_mvvm/services/app_translator.dart';

class RandomQuoteModel {
  String? author;
  String? quote;

  Future<String> get getName async =>
      await AppTranslator.instance.translate(quote!);
  RandomQuoteModel({this.author, this.quote});

  RandomQuoteModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    quote = json['quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['quote'] = this.quote;
    return data;
  }
}
