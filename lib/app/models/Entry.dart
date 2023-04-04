import 'package:mao_de_vakka/app/models/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Entry {
  String id =
      Random().nextInt(100).toString() + DateTime.now().millisecond.toString();
  String title;
  double value;
  Category category;
  Timestamp date = Timestamp.fromDate(DateTime.now());

  Entry(this.value)
      : title = 'Crédito',
        category = Category.Saldo;

  Entry.expense(this.title, this.value, this.category, this.date);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category.name,
      'value': value,
      'date': date,
    };
  }
}