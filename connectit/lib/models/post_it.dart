import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/sns_ids.dart';

// 포스트잇 정보를 저장하는 데이터 모델
class PostIt {
  String? uid;
  String? title;
  String? description;
  String? mbti;
  List<String>? hobbies;
  List<String>? topics;
  List<String>? keywords;
  SnsIds? snsIds;

  // 포스트잇 정보를 초기화하는 생성자
  PostIt.initialize({
    required this.uid,
    required this.title,
    required this.description,
    required this.mbti,
    required this.hobbies,
    required this.topics,
    required this.snsIds,
  }) : keywords = [mbti!] + hobbies! + topics!;

  // Firestore Doc에서 데이터를 읽어와 PostIt 인스턴스를 생성하는 생성자
  // Board에서 데이터를 읽어올 때 사용
  PostIt.fromFirestoreDoc({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data()?['postIt'];

    uid = data?['uid'];
    title = data?['title'];
    description = data?['description'];
    mbti = data?['mbti'];
    hobbies = data?['hobbies'] is Iterable ? List.from(data?['hobbies']) : [];
    topics = data?['topics'] is Iterable ? List.from(data?['topics']) : [];
    keywords = [mbti!] + hobbies! + topics!;
    snsIds = SnsIds.fromFirestoreDoc(
      snapshot: snapshot,
      options: options,
    );
  }

  // Firestore 데이터를 읽어와 PostIt 인스턴스를 생성하는 생성자
  // Storage에 저장된 데이터를 읽어올 때 사용
  PostIt.fromFirestoreData({
    required Map<String, dynamic>? data,
  }) {
    uid = data?['uid'];
    title = data?['title'];
    description = data?['description'];
    mbti = data?['mbti'];
    hobbies = data?['hobbies'] is Iterable ? List.from(data?['hobbies']) : [];
    topics = data?['topics'] is Iterable ? List.from(data?['topics']) : [];
    keywords = [mbti!] + hobbies! + topics!;
    snsIds = SnsIds.fromFirestoreData(
      data: data?['snsIds'],
    );
  }

  // Firestore에 데이터를 쓰기 위해 PostIt 인스턴스를 Map으로 변환하는 메서드
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid ?? '',
      'title': title ?? '',
      'description': description ?? '',
      'mbti': mbti ?? '',
      'hobbies': hobbies ?? [],
      'topics': topics ?? [],
      'snsIds': snsIds?.toFirestore(),
    };
  }
}