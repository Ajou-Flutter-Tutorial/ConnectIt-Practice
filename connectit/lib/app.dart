import 'package:connectit/screens/route_screen.dart';
import 'package:flutter/material.dart';

// 애플리케이션의 기본적인 정보 설정을 위한 화면

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConnectIt',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
        ),
      ),
      home: const RouteScreen(),
    );
  }
}