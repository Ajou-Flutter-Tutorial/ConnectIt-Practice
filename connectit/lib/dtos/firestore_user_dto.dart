import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/application_user.dart';
import '../models/post_it.dart';

// 유저 정보를 저장하는 데이터 모델
class FirestoreUserDTO {
  final ApplicationUser? user;
  final PostIt? postIt;

  FirestoreUserDTO({
    this.user,
    this.postIt,
  });

  // Firestore에서 데이터를 읽어와 FirestoreUserDTO 인스턴스를 생성하는 생성자
  factory FirestoreUserDTO.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();

    FirestoreUserDTO firestoreUserDTO =  FirestoreUserDTO(
      user: data?['info'] != null ? ApplicationUser.fromFirestore(
        snapshot: snapshot,
        options: options,
      ) : null,
      postIt: data?['postIt'] != null ? PostIt.fromFirestoreDoc(
        snapshot: snapshot,
        options: options,
      ) : null,
    );

    return firestoreUserDTO;
  }

  // Firestore에 데이터를 쓰기 위해 FirestoreUserDTO 인스턴스를 Map으로 변환하는 메서드
  Map<String, dynamic> toFirestore() {
    return {
      'user': user?.toFirestore(),
      'postIt': postIt?.toFirestore(),
    };
  }
}