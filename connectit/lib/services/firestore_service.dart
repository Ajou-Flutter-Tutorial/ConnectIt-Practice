import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectit/dtos/firestore_storage_dto.dart';
import 'package:connectit/dtos/firestore_user_dto.dart';
import 'package:connectit/models/application_user.dart';
import 'package:connectit/models/post_it.dart';

import '../dtos/firestore_post_dto.dart';
import '../utils/logger.dart';

// Firebase Firestore CRUD 동작을 수행하기 위한 서비스 클래스
// USERS, BOARD, STORAGE Collection에 대한 CRUD 동작을 수행하는 메서드를 정의
// Singleton 패턴을 적용하여 인스턴스를 하나만 생성하고, 어디서든 접근할 수 있도록 함

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// USERS COLLECTION

  // 유저 정보를 생성하는 메서드
  Future<void> createUserCollection({required ApplicationUser user}) async {
    await _firestore.collection('users').doc(user.uid).set({
      'info': user.toFirestore(),
    }, SetOptions(merge: true)).onError((error, stackTrace) {
      logger.e('[Firestore] 유저 생성 실패\n$error\n$stackTrace');

      throw Exception(error);
    });
  }

  // 유저 정보를 읽어오는 메서드
  Future<FirestoreUserDTO?> readUserCollection({required ApplicationUser user}) async {
    FirestoreUserDTO firestoreUserDTO = FirestoreUserDTO();

    firestoreUserDTO = await _firestore.collection('users').doc(user.uid).get().then((snapshot) {
      return FirestoreUserDTO.fromFirestore(snapshot: snapshot);
    }).onError((error, stackTrace) {
      logger.e('[Firestore] 유저 정보 읽기 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });

    return firestoreUserDTO;
  }

  // 유저 정보를 업데이트하는 메서드
  Future<void> updateUserCollection({
    required ApplicationUser user,
    required PostIt postIt,
  }) async {
    await _firestore.collection('users').doc(user.uid).update({
      'info': user.toFirestore(),
      'postIt': postIt.toFirestore(),
    }).onError((error, stackTrace) {
      logger.e('[Firestore] 유저 정보 업데이트 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });
  }

  // 유저 정보를 삭제하는 메서드
  Future<void> deleteUserCollection({required String uid}) async {
    await _firestore.collection('users').doc(uid).delete().onError((error, stackTrace) {
      logger.e('[Firestore] 유저 정보 삭제 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });
  }

  /// BOARD COLLECTION

  // 포스트잇 목록에 포스트잇을 생성(나의 포스트잇 붙이기)하는 메서드
  Future<void> createBoardCollection({
    required ApplicationUser user,
    required PostIt postIt,
  }) async {
    await _firestore.collection('board').doc(user.uid).set({
        'postIt': postIt.toFirestore(),
      }, SetOptions(merge: true),
    ).onError((error, stackTrace) {
      logger.e('[Firestore] 게시글 생성 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });
  }

  // 포스트잇 목록을 읽어오는 메서드
  Future<FirestorePostDTO?> readBoardCollection({required ApplicationUser user}) async {
    FirestorePostDTO firestorePostDTO = FirestorePostDTO();

    firestorePostDTO = await _firestore.collection('board').get().then((querySnapshot) {
      return FirestorePostDTO.fromFirestore(querySnapshot: querySnapshot);
    }).onError((error, stackTrace) {
      logger.e('[Firestore] 게시글 읽기 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });

    return firestorePostDTO;
  }

  // 포스트잇 목록을 업데이트하는 메서드
  Future<void> updateBoardCollection({
    required ApplicationUser user,
    required PostIt postIt,
  }) async {
    final docReference = _firestore.collection('board').doc(user.uid);

    await docReference.get().then((snapshot) {
      if (snapshot.exists) {
        docReference.update({
          'postIt': postIt.toFirestore(),
        }).onError((error, stackTrace) {
          logger.e('[Firestore] 게시글 업데이트 실패\n$error\n$stackTrace');

          throw Exception(error);
        });
      }
    }).onError((error, stackTrace) {
      logger.e('[Firestore] 게시글 업데이트 실패\n$error\n$stackTrace');

      throw Exception(error);
    });
  }

  // 포스트잇 목록에서 포스트잇을 삭제하는 메서드
  Future<void> deleteBoardCollection({required String uid}) async {
    await _firestore.collection('board').doc(uid).delete().onError((error, stackTrace) {
      logger.e('[Firestore] 게시글 삭제 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });
  }

  /// STORAGE COLLECTION

  // 스토리지를 생성하는 메서드
  Future<void> createStorageCollection({required ApplicationUser user}) async {
    final docReference = _firestore.collection('storage').doc(user.uid);

    await docReference.get().then((snapshot) {
      if (!snapshot.exists) {
        docReference.set({
          'postIts': [],
        }, SetOptions(merge: false)).onError((error, stackTrace) {
          logger.e('[Firestore] 스토리지 생성 실패\n$error\n$stackTrace');
          
          throw Exception(error);
        });
      }
    }).onError((error, stackTrace) {
      logger.e('[Firestore] 스토리지 생성 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });
  }

  // 스토리지를 읽어오는 메서드
  Future<FirestoreStorageDTO?> readStorageCollection({required ApplicationUser user}) async {
    FirestoreStorageDTO firestoreStorageDTO = FirestoreStorageDTO();

    firestoreStorageDTO = await _firestore.collection('storage').doc(user.uid).get().then((snapshot) {
      return FirestoreStorageDTO.fromFirestore(snapshot: snapshot);
    }).onError((error, stackTrace) {
      logger.e('[Firestore] 스토리지 읽기 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });

    return firestoreStorageDTO;
  }

  // 스토리지를 업데이트(보드에 있는 포스트있을 보관함에 보관)하는 메서드
  Future<void> updateAddStorageCollection({
    required ApplicationUser user,
    required PostIt postIt,
  }) async {
    await _firestore.collection('storage').doc(user.uid).update({
      'postIts': FieldValue.arrayUnion([postIt.toFirestore()]),
    }).onError((error, stackTrace) {
      logger.e('[Firestore] 스토리지 포스트잇 추가 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });
  }

  // 스토리지를 업데이트(보관함에 있는 포스트잇을 삭제)하는 메서드
  Future<void> updateSubStorageCollection({
    required ApplicationUser user,
    required PostIt postIt,
  }) async {
    await _firestore.collection('storage').doc(user.uid).update({
      'postIts': FieldValue.arrayRemove([postIt.toFirestore()]),
    }).onError((error, stackTrace) {
      logger.e('[Firestore] 스토리지 포스트잇 삭제 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });
  }

  // 스토리지를 삭제하는 메서드
  Future<void> deleteStorageCollection({required String uid}) async {
    await _firestore.collection('storage').doc(uid).delete().onError((error, stackTrace) {
      logger.e('[Firestore] 스토리지 삭제 실패\n$error\n$stackTrace');
      
      throw Exception(error);
    });
  }
}