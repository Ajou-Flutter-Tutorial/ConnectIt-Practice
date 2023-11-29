import 'package:connectit/models/post_it.dart';
import 'package:flutter/cupertino.dart';

import '../models/application_user.dart';
import '../services/firestore_service.dart';

// 보드 화면에 데이터를 관리하는 메서드
class BoardProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  ApplicationUser? _user;
  List<PostIt>? _postIts;

  get postIts => _postIts;

  // 보드 정보를 초기화하는 메소드
  Future<void> initialize({required ApplicationUser user}) async {
    setUser(user: user);
    await _load();
  }

  // 보드 정보를 새로고침하는 메소드
  Future<void> refresh() async {
    await _load();
  }

  // 보드 정보를 읽어오는 메소드
  Future<void> _load() async {
    await _firestoreService.readBoardCollection(user: _user!).then((value) {
      _postIts = value?.postIts;
    });

    notifyListeners();
  }

  // 유저 정보를 설정하는 메소드
  void setUser({required ApplicationUser user}) async {
    _user = user;
  }

  // 보드에 포스트잇을 붙이는(데이터 생성) 메소드
  Future<void> attachPostIt({required PostIt postIt}) async {
    await _firestoreService.createBoardCollection(user: _user!, postIt: postIt).then((_) async {
      await _load();
    });
  }

  // 보드에 포스트잇 정보를 업데이트(데이터 수정) 하는 메소드
  Future<void> updatePostIt({required PostIt postIt}) async {
    await _firestoreService.updateBoardCollection(user: _user!, postIt: postIt).then((_) async {
      await _load();
    });
  }

  // 보드에 포스트잇을 떼는(데이터 삭제) 메소드
  Future<void> detachPostIt({required PostIt postIt}) async {
    await _firestoreService.deleteBoardCollection(uid: postIt.uid!).then((_) async {
      await _load();
    });
  }
}