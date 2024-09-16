import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider.dart';

import 'db_helper.dart';
import 'login_page.dart';

void main() async{

  runApp(ChangeNotifierProvider(
      child:  MyApp(),
      create: (context)=>taskprovider(dBhelper: DBhelper.getinstance())),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:loginpage(),
    );

  }
}
