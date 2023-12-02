import 'package:connectit/components/next_button.dart';
import 'package:connectit/models/application_user.dart';
import 'package:connectit/providers/profile_provider.dart';
import 'package:connectit/screens/post/post_screen.dart';
import 'package:connectit/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/post_it_card.dart';
import '../../models/post_it.dart';
import '../../utils/design.dart';
import 'components/profile_info_card.dart';

// 내 프로필과 포스트잇을 열람하고 포스트잇을 수정하는 화면으로 이동하는 동작 수행
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          icon: const Icon(Icons.settings_outlined),
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
          // Consumer를 사용하여 ProfileProvider의 user와 postIt 데이터를 사용
          // ProfileProvider의 user와 postIt 데이터가 변경되면 자동으로 화면을 업데이트
          child: Consumer<ProfileProvider>(
            builder: (BuildContext context, ProfileProvider profileProvider, Widget? child) {
              ApplicationUser user = profileProvider.user;
              PostIt? postIt = profileProvider.postIt;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SectionTitle(
                    title: '나의 정보',
                    isAction: false,
                  ),
                  ProfileInfoCard(
                    userProfileUrl: user.photoURL,
                    userName: user.name!,
                    userEmail: user.email!,
                  ),
                  const SizedBox(height: defaultDoubleSpacing),
                  SectionTitle(
                    title: '나의 포스트',
                    isAction: true,
                    onPressed: () => _onPressedMyPost(context),
                  ),
                  if (postIt != null) ... [
                    PostItCard(
                      title: postIt.title!,
                      description: postIt.description!,
                      keywords: postIt.keywords!,
                      snsIds: postIt.snsIds!,
                      isShowSnsIds: true,
                      isOnTap: false,
                    ),
                  ]
                  else ... [
                    Text(
                      '아직 작성한 포스트가 없습니다.',
                      style: DesignerTextStyle.paragraph3,
                    ),
                    const SizedBox(height: defaultSpacing),
                    NextButton(
                      onPressed: () => _onPressedMyPost(context),
                      label: '새 포스트 작성하기',
                    ),
                  ],
                  const SizedBox(height: defaultDoubleSpacing),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  void _onPressedAction(BuildContext context) {}

  void _onPressedMyPost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PostScreen(),
      ),
    );
  }
}
