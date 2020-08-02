import 'package:blog/providers/main_screen_provider.dart';
import 'package:blog/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<MainScreenProvider>(
    create: (providerContext) => MainScreenProvider(),
    builder: (context, child) => MaterialApp(
          home: MainScreen(),
          debugShowCheckedModeBanner: false,
          title: 'Todo',
        )));
