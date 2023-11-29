import 'package:flutter/material.dart';

import '../../enums/mbti.dart';
import '../../utils/design.dart';
import 'components/post_mbti_select_card.dart';
import '../../components/next_button.dart';
import 'components/post_sns_ids_edit_card.dart';
import 'components/post_text_edit_card.dart';

// 포스트잇을 작성하고 수정하는 동작 수행
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('내 포스트 작성'),
      centerTitle: true,
      scrolledUnderElevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(defaultSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('포스트 제목', style: DesignerTextStyle.title1),
                    const PostTextEditCard(
                      textEditingController: null,
                      hintText: '간단히 나를 표현해주세요!',
                      maxLength: 32,
                    ),
                    const SizedBox(height: defaultDoubleSpacing),
                    Text('포스트 내용', style: DesignerTextStyle.title1),
                    const PostTextEditCard(
                      textEditingController: null,
                      hintText: '자유롭게 나를 표현해주세요!',
                      maxLength: 256,
                      maxLines: 5,
                    ),
                    const SizedBox(height: defaultDoubleSpacing),
                    Text('나의 MBTI', style: DesignerTextStyle.title1),
                    PostMbtiSelectCard(
                      onSelected: (_) {},
                      initialSelection: 'ENFP',
                    ),
                    const SizedBox(height: defaultDoubleSpacing),
                    Text('나의 취미', style: DesignerTextStyle.title1),
                    const PostTextEditCard(
                      textEditingController: null,
                      hintText: '취미를 쉼표(,)로 구분하여 적어주세요!',
                      maxLength: 128,
                      maxLines: 3,
                    ),
                    const SizedBox(height: defaultDoubleSpacing),
                    Text('나의 관심사', style: DesignerTextStyle.title1),
                    const PostTextEditCard(
                      textEditingController: null,
                      hintText: '관심사를 쉼표(,)로 구분하여 적어주세요!',
                      maxLength: 128,
                      maxLines: 3,
                    ),
                    const SizedBox(height: defaultDoubleSpacing),
                    Text('나의 SNS ID', style: DesignerTextStyle.title1),
                    const PostSnsIdsEditCard(
                      kakaoTalkIdController: null,
                      instagramIdController: null,
                      facebookIdController: null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultSpacing),
            child: NextButton(
              onPressed: () => _onPressedSave(),
              label: '포스트 저장하기',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressedSave() async {}
}
