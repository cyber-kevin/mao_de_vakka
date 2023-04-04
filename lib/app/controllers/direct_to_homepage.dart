import "package:flutter/material.dart";
import 'package:mao_de_vakka/app/views/category_details.dart';
import "package:mao_de_vakka/app/views/config_page.dart";
import 'package:mao_de_vakka/app/views/expenses_page.dart';
import 'package:mao_de_vakka/app/views/homepage.dart';
import "package:mao_de_vakka/app/views/TransactionsPage.dart";
import "package:mao_de_vakka/app/views/config_page.dart";

class RedirectPage extends StatefulWidget {
  Map<String, dynamic> userData;

  RedirectPage({super.key, required this.userData});

  @override
  _RedirectPage createState() => _RedirectPage();
}

class _RedirectPage extends State<RedirectPage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setCurrentPage(page) {
    setState(() {
      paginaAtual = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: setCurrentPage,
          children: [
            HomePage(
              userData: widget.userData,
            ),
            TransactionsPage(
              userData: widget.userData,
            ),
            ExpensesPage(
              userData: widget.userData,
            ),
            CategoryDetails(
              userData: widget.userData,
            ),
            ConfigPage(
              userData: widget.userData,
            )
          ],
        ),
        bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60), topRight: Radius.circular(60)),
            child: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              currentIndex: paginaAtual,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color.fromARGB(255, 34, 197, 94),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.attach_money), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_outline), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
              ],
              onTap: (page) {
                pc.animateToPage(page,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease);
              },
            )));
  }
}
