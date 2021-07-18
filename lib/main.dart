import 'package:flutter/material.dart';
import './screens/transation_screen.dart';
import './constant.dart';
import './screens/transation_screen.dart';
import './screens/personal_screen.dart';
import './screens/couple_saving_screen.dart';
import './screens/budget_add_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(primarySwatch: kMainColor, accentColor: Colors.yellow),
      home: TransationScreen(),
      initialRoute: TransationScreen.id,
      routes: {
        TransationScreen.id: (context) => TransationScreen(),
        PersonalScreen.id: (context) => PersonalScreen(),
        CoupleSavingScreen.id: (context) => CoupleSavingScreen(),
      },
    );
  }
}
