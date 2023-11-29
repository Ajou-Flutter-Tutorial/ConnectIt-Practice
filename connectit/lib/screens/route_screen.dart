import 'package:connectit/screens/tab/tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/login_screen.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Firebase Authentication 인증 상태를 확인하는 로직
    // 이미 로그인이 되어있으면 TabScreen을 보여줌
    // 로그인이 되어있지 않으면 LoginScreen을 보여줌

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return const TabScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
