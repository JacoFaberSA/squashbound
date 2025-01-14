import 'package:flutter/material.dart';
import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/screens/home.dart';
import 'package:squashbound/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Battle(
      child: Decks(
        child: MaterialApp(
          title: 'Squashbound',
          debugShowCheckedModeBanner: false,
          theme: SquashboundTheme.theme,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
