import 'package:connectit/enums/sign_in_method.dart';
import 'package:connectit/screens/login/components/apple_login_button.dart';
import 'package:connectit/screens/login/components/google_login_button.dart';
import 'package:connectit/utils/design.dart';
import 'package:connectit/services/authentication_service.dart';

import 'package:flutter/material.dart';

/// on android platform, it shows only google signin
class LoginButtonsByPlatform extends StatelessWidget {
  LoginButtonsByPlatform({
    required this.hasAgreed,
    Key? key,
  }) : super(key: key);

  final bool hasAgreed;

  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    // 플랫폼에 따라 적절한 로그인 버튼을 보여줌
    // Android에서는 구글 로그인 버튼 만을 보여줌
    // iOS에서는 구글 및 애플 로그인 버튼을 모두 보여줌

    var platform = Theme.of(context).platform;

    return Column(
      children: [
        GestureDetector(
          onTap: () => _onTappedGoogleLogin(context),
          child: const GoogleLoginButton(),
        ),
        const SizedBox(height: defaultSpacing),
        Visibility(
          visible: platform == TargetPlatform.iOS,
          child: GestureDetector(
            onTap: () => _onTappedAppleLogin(context),
            child: const AppleLoginButton(),
          ),
        ),
      ],
    );
  }

  // 구글 로그인 버튼을 누르면 구글 로그인 동작을 수행
  // 만약 서비스 이용약관 및 개인정보 처리 방침에 동의하지 않으면 알림 표시
  void _onTappedGoogleLogin(BuildContext context) async {
    if (hasAgreed) {
      _handleSigningIn(context, signInMethod: SignInMethod.GOOGLE);
    } else {
      _showAgreementNeeded(context: context);
      return;
    }
  }

  // 애플 로그인 버튼을 누르면 구글 로그인 동작을 수행
  // 만약 서비스 이용약관 및 개인정보 처리 방침에 동의하지 않으면 알림 표시
  void _onTappedAppleLogin(BuildContext context) async {
    if (hasAgreed) {
      _handleSigningIn(context, signInMethod: SignInMethod.APPLE);
    } else {
      _showAgreementNeeded(context: context);
    }
  }

  // Authentication Service를 이용하여 로그인 동작을 수행
  void _handleSigningIn(BuildContext context, {SignInMethod? signInMethod}) async {
    await _authenticationService.signIn(signInMethod: signInMethod);
  }

  // 만약 서비스 이용약관 및 개인정보 처리 방침에 미 동의시 Dialog로 알림 표시
  void _showAgreementNeeded({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '로그인 실패',
            style: DesignerTextStyle.header1,
          ),
          content: Text('원활한 서비스 이용을 위해서는 서비스 이용약관과 개인정보 처리방침에 대한 동의가 필요합니다.', style: DesignerTextStyle.paragraph2),
          actions: <Widget>[
            ElevatedButton(
              child: Text('확인', style: DesignerTextStyle.caption1.apply(color: Colors.black87)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
