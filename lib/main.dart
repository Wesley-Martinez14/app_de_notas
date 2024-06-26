import 'package:app_de_notas/pages/list_page.dart';
import 'package:app_de_notas/pages/save_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ListPage.ROUTE,
      routes: {
        ListPage.ROUTE : (_) => const ListPage(),
        SavePage.ROUTE : (_) => const SavePage()

      },
    );
  }
}