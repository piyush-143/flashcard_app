import 'package:flashcard_app/view/home_view.dart';
import 'package:flashcard_app/view_model/db_provider.dart';
import 'package:flashcard_app/view_model/index_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DBProvider()),
        ChangeNotifierProvider(create: (_) => IndexProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.red,
        ),
        home: const SafeArea(child: HomeView()),
        //home: const CustomFlashCard(),
      ),
    );
  }
}
