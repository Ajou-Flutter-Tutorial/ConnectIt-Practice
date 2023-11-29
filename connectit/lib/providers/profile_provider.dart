import 'package:connectit/models/application_user.dart';
import 'package:connectit/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/post_it.dart';
import '../models/sns_ids.dart';
import '../services/authentication_service.dart';

// 프로필 화면의 데이터를 관리하는 프로바이더
class ProfileProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthenticationService _authenticationService = AuthenticationService();

  ApplicationUser? _user;
  PostIt? _postIt;

  get user => _user;
  get postIt => _postIt;

  // 유저 정보를 초기화하는 메서드
  Future<void> initialize({required User user}) async {
    await setUser(user: user).then((_) async {
      await _load();
    });
  }

  // 유저 정보를 새로고침하는 메서드
  Future<void> _load() async {
    await _firestoreService.readUserCollection(user: _user!).then((value) {
      _user = value?.user;
      _postIt = value?.postIt;
    });

    notifyListeners();
  }

  // 회원가입시 유저 정보를 Firestore에 설정하는 메서드
  Future<void> setUser({
    required User user,
  }) async {
    _user = ApplicationUser.initialize(
      uid: user.uid,
      name: user.displayName ?? 'Anonymous',
      email: user.email,
      photoURL: user.photoURL,
    );

    await _firestoreService.createUserCollection(user: _user!);

    notifyListeners();
  }

  // Firestore에 포스트잇을 설정(작성, 수정)하는 메서드
  Future<void> setPostIt({
    required String title,
    required String description,
    required String mbti,
    required String hobbies,
    required String topics,
    required String kakaotalkId,
    required String instagramId,
    required String facebookId,
  }) async {
    _postIt = PostIt.initialize(
      uid: _user!.uid,
      title: title,
      description: description,
      mbti: mbti,
      hobbies: hobbies.replaceAll(' ', '').split(','),
      topics: topics.replaceAll(' ', '').split(','),
      snsIds: SnsIds.initialize(
        kakaotalk: kakaotalkId,
        instagram: instagramId,
        facebook: facebookId,
      ),
    );

    await _firestoreService.updateUserCollection(
      user: _user!,
      postIt: postIt,
    );

    notifyListeners();
  }

  // 로그아웃을 위한 메서드
  Future<void> signOut() async {
    await _authenticationService.signOut();

    notifyListeners();
  }

  // 회원탈퇴를 위한 메서드
  Future<void> withdraw () async {
    await _firestoreService.deleteUserCollection(uid: _user!.uid!);
    await _firestoreService.deleteBoardCollection(uid: _user!.uid!);
    await _firestoreService.deleteStorageCollection(uid: _user!.uid!);

    await signOut();
  }
}
