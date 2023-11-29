import 'package:connectit/components/section_title.dart';
import 'package:connectit/utils/tester.dart';
import 'package:flutter/material.dart';

import '../../components/post_it_card.dart';
import '../../models/post_it.dart';
import '../../utils/design.dart';
import 'components/board_fab.dart';

// 내 포스트잇을 붙이고, 상대방의 포스트잇을 열람하고 때오는 동작 수행
class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: BoardFAB(
        onTap: () => _onTapFAB(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              const SectionTitle(title: '포스트잇 목록', isAction: false),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: postItsTester.length,
                itemBuilder: (BuildContext context, int index) {
                  return PostItCard(
                    title: postItsTester[index].title!,
                    description: postItsTester[index].description!,
                    keywords: postItsTester[index].keywords!,
                    snsIds: postItsTester[index].snsIds!,
                    isShowSnsIds: false,
                    isOnTap: true,
                    onTap: () => _onTapPostIt(context, postIt: postItsTester[index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: defaultSpacingHalf);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedAction(BuildContext context) async {}

  void _onTapFAB(BuildContext context) async {}

  void _onTapPostIt(BuildContext context, {required PostIt postIt}) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('포스트잇을 때어가겠습니까?', style: DesignerTextStyle.title2),
        content: Text('포스트잇을 때어가면 나의 보관함과 상대방의 보관함에 서로의 포스트잇이 보관됩니다.', style: DesignerTextStyle.paragraph3),
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
