import 'package:cloud_firestore/cloud_firestore.dart';

// SNS ID 정보를 저장하는 데이터 모델
class SnsIds {
  String? kakaotalk;
  String? instagram;
  String? facebook;

  // SNS ID 정보를 초기화하는 생성자
  SnsIds.initialize({
    this.kakaotalk,
    this.instagram,
    this.facebook,
  });

  // Firestore Doc에서 데이터를 읽어와 SnsIds 인스턴스를 생성하는 생성자
  // Board에서 데이터를 읽어올 때 사용
  SnsIds.fromFirestoreDoc({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data()?['postIt']['snsIds'];

    kakaotalk = data?['kakaotalk'];
    instagram =  data?['instagram'];
    facebook = data?['facebook'];
  }

  // Firestore 데이터를 읽어와 SnsIds 인스턴스를 생성하는 생성자
  // Storage에 저장된 데이터를 읽어올 때 사용
  SnsIds.fromFirestoreData({
    required Map<String, dynamic>? data,
  }) {
    kakaotalk = data?['kakaotalk'];
    instagram =  data?['instagram'];
    facebook = data?['facebook'];
  }

  // Firestore에 데이터를 쓰기 위해 SnsIds 인스턴스를 Map으로 변환하는 메서드
  Map<String, dynamic> toFirestore() {
    return {
      'kakaotalk': kakaotalk ?? '',
      'instagram': instagram ?? '',
      'facebook': facebook ?? '',
    };
  }
}