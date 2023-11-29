import 'package:cloud_firestore/cloud_firestore.dart';

// 유저 정보를 저장하는 데이터 모델
class ApplicationUser {
  String? uid;
  String? name;
  String? email;
  String? photoURL;

  // 유저 정보를 초기화하는 생성자
  ApplicationUser.initialize({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoURL,
  });

  // Firestore에서 데이터를 읽어와 ApplicationUser 인스턴스를 생성하는 생성자
  ApplicationUser.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data()?['info'];

    uid = data?['uid'];
    name = data?['name'];
    email = data?['email'];
    photoURL = data?['photoURL'];
  }

  // Firestore에 데이터를 쓰기 위해 ApplicationUser 인스턴스를 Map으로 변환하는 메서드
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid ?? '',
      'name': name ?? '',
      'email': email ?? '',
      'photoURL': photoURL ?? '',
    };
  }
}
