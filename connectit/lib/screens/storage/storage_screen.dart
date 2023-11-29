import 'package:flutter/material.dart';

// 추후 Storage Screen 구현을 위한 스켈레톤 코드
// 내가 때온 포스트잇을 저장하고 네트워킹을 위한 SNS ID를 확인하는 동작 수행

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 현재는 구현의 편의를 위해 AppBar와 Body를 메소드를 사용하여 분리
    // 그러나 이는 안티 패턴 이므로 추후 최종적인 코드 리팩토링에서 정리할 것

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('ConnectIt'),
      actions: [
        IconButton(
          onPressed: () => _onPressedAction(context),
          icon: const Icon(Icons.refresh_outlined),
        ),
      ],
      centerTitle: false,
      scrolledUnderElevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(),
    );
  }

  void _onPressedAction(BuildContext context) async {

  }
}
