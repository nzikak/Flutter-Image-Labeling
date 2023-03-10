import 'package:flutter/material.dart' hide ImageProvider;
import 'package:image_labelling/home.dart';
import 'package:image_labelling/image_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageProvider(),
      builder: (context, _) {
        return MaterialApp(
          title: 'MLKit Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        );
      }
    );
  }
}

