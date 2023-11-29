import 'package:connectit/utils/design.dart';
import 'package:flutter/material.dart';

import 'components/login_buttons_by_platform.dart';
import 'components/signing_agreement_notice.dart';

// 로그인이 되어 있지 않을 때 로그인 수행하는 화면
// 서비스 이용약관 및 개인정보 처리방침 열람과 동의를 할 수 있음
// 서비스 이용약관 및 개인정보 처리방침 동의 후 각 플랫폼의 로그인 버튼을 통해 로그인 수행

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgrounds/login_background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, -0.2),
                colors: [
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.9),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultSpacing),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'CONNECTIT',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      '흥미를 잇다. 사람을 잇다.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 150),
                    SigningAgreementNotice(
                      hasAgreed: _agreed,
                      onTappedAgreementButton: () => _onTappedAgreementButton(),
                    ),
                    const SizedBox(height: defaultSpacing),
                    LoginButtonsByPlatform(hasAgreed: _agreed),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 서비스 이용약관 및 개인정보 처리방침 동의 버튼을 눌렀을 때 호출됨
  // 동의 여부를 반전시켜 상태를 업데이트 함
  void _onTappedAgreementButton() {
    setState(() {
      _agreed = !_agreed;
    });
  }
}
