import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectit/models/post_it.dart';

// 포스트잇 목록 데이터를 저장하는 데이터 모델
class FirestorePostDTO {
  final List<PostIt>? postIts;

  FirestorePostDTO({
    this.postIts,
  });

  // Firestore에서 데이터를 읽어와 FirestorePostDTO 인스턴스를 생성하는 생성자
  factory FirestorePostDTO.fromFirestore({
    required QuerySnapshot<Map<String, dynamic>> querySnapshot,
    SnapshotOptions? options,
  }) {
    final docs = querySnapshot.docs;

    FirestorePostDTO firestoreUserDTO =  FirestorePostDTO(
      postIts: docs.isNotEmpty ? docs.map((doc) {
        return PostIt.fromFirestoreDoc(
          snapshot: doc,
          options: options,
        );
      }).toList() : [],
    );

    return firestoreUserDTO;
  }

  // Firestore에 데이터를 쓰기 위해 FirestorePostDTO 인스턴스를 Map으로 변환하는 생성자
  Map<String, dynamic> toFirestore() {
    return {
      'postIts': postIts,
    };
  }
}