import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectit/models/post_it.dart';

// 포스트잇 보관함의 데이터를 저장하는 데이터 모델
class FirestoreStorageDTO {
  final List<PostIt>? postIts;

  FirestoreStorageDTO({
    this.postIts,
  });

  // Firestore에서 데이터를 읽어와 FirestoreStorageDTO 인스턴스를 생성하는 생성자
  factory FirestoreStorageDTO.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();

    FirestoreStorageDTO firestoreStorageDTO =  FirestoreStorageDTO(
      postIts: data?['postIts'] is List ? (data?['postIts'] as List).map((item) => PostIt.fromFirestoreData(data: item)).toList() : [],
    );

    return firestoreStorageDTO;
  }

  // Firestore에 데이터를 쓰기 위해 FirestoreStorageDTO 인스턴스를 Map으로 변환하는 생성자
  Map<String, dynamic> toFirestore() {
    return {
      'postIts': postIts,
    };
  }
}