import 'package:mao_de_vakka/app/models/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Entry {
  String title;
  double value;
  Category category;
  Timestamp date = Timestamp.fromDate(DateTime.now());

  Entry(this.value)
      : title = 'Crédito',
        category = Category.Saldo;

  Entry.expense(this.title, this.value, this.category);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category.name,
      'value': value,
      'date': date,
    };
  }
}