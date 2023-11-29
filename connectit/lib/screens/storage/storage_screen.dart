import 'package:flutter/material.dart';

import '../../components/post_it_card.dart';
import '../../components/section_title.dart';
import '../../models/post_it.dart';
import '../../utils/design.dart';
import '../../utils/tester.dart';

// 내가 때온 포스트잇을 저장하고 네트워킹을 위한 SNS ID를 확인하는 동작 수행
class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: '보관한 포스트잇', isAction: false),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: postItsTester.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      PostItCard(
                        title: postItsTester[index].title!,
                        description: postItsTester[index].description!,
                        keywords: postItsTester[index].keywords!,
                        snsIds: postItsTester[index].snsIds!,
                        isShowSnsIds: true,
                        isOnTap: false,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () => _onPressedRemove(context, postIt: postItsTester[index]),
                          icon: const Icon(Icons.close_outlined, color: Colors.black87),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: defaultSpacingHalf);
                },
              ),
              const SizedBox(height: defaultDoubleSpacing),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedAction(BuildContext context) async {}

  void _onPressedRemove(BuildContext context, {required PostIt postIt}) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('포스트잇을 삭제하겠습니까?', style: DesignerTextStyle.title2),
        content: Text('삭제된 포스트잇은 영구적으로 삭제되며 복구할 수 없습니다.', style: DesignerTextStyle.paragraph3),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('아니요', style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('네', style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
