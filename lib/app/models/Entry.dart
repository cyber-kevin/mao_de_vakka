import 'package:mao_de_vakka/app/models/Category.dart';

class Entry {
  String title;
  double value;
  Category category;
  DateTime date = DateTime.now();

  Entry(this.value)
      : title = 'Novo saldo',
        category = Category.Saldo;

  Entry.expense(this.title, this.value, this.category);
}
