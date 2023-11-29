import 'package:connectit/models/post_it.dart';
import 'package:flutter/cupertino.dart';

import '../models/application_user.dart';
import '../services/firestore_service.dart';

// 포스트잇 보관함 화면에 데이터를 관리하는 메서드
class StorageProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  ApplicationUser? _user;
  List<PostIt>? _postIts;

  get postIts => _postIts;

  // 포스트잇 보관함 정보를 초기화하는 메서드
  Future<void> initialize({required ApplicationUser user}) async {
    setUser(user: user);
    await _initializeStorage();
  }

  // 포스트잇 보관함 정보를 새로고침하는 메서드
  Future<void> refresh() async {
    await _load();
  }

  // 포스트잇 보관함 정보를 읽어오는 메서드
  Future<void> _load() async {
    await _firestoreService.readStorageCollection(user: _user!).then((value) {
      _postIts = value?.postIts;
    });

    notifyListeners();
  }

  // 유저 정보를 설정하는 메서드
  void setUser({required ApplicationUser user}) async {
    _user = user;
  }

  // 포스트잇 보관함에 유저별 포스트인 보관함 Document를 생성하는 메서드
  Future<void> _initializeStorage() async {
    await _firestoreService.createStorageCollection(user: _user!).then((_) async {
      await _load();
    });
  }

  // 포스트잇 보관함에 포스트잇을 때와서 저장하는(데이터 생성) 메서드
  Future<void> createPostIt({required PostIt postIt}) async {
    await _firestoreService.updateAddStorageCollection(user: _user!, postIt: postIt).then((_) async {
      await _load();
    });
  }

  // 포스트잇 보관함에 포스트잇을 때서 버리는(데이터 삭제) 메서드
  Future<void> removePostIt({required PostIt postIt}) async {
    await _firestoreService.updateSubStorageCollection(user: _user!, postIt: postIt).then((_) async {
      await _load();
    });
  }
}