import 'package:flutter/material.dart';

import '../../../utils/design.dart';

// 설정 화면에서 사용하는 라벨 위젯
class SettingLabel extends StatelessWidget {
  final String optionName;

  const SettingLabel({
    required this.optionName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        top: defaultSpacing,
        left: defaultSpacing,
        bottom: defaultSpacing,
      ),
      child: Text(
        optionName,
        style: DesignerTextStyle.title2,
      ),
    );
  }
}
