import '../models/post_it.dart';
import '../models/sns_ids.dart';

List<PostIt> postItsTester = [
  PostIt.initialize(
    uid: 'uid_1',
    title: 'Test Post It 1',
    description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500',
    mbti: 'ENTP',
    hobbies: ['Music', 'Photo', 'Movie', 'Book', 'Game', 'Travel', 'Coffee'],
    topics: ['Computer Science', 'Junior'],
    snsIds: SnsIds.initialize(
      instagram: 'instagram_id_1',
      facebook: 'facebook_id_1',
      kakaotalk: 'kakaotalk_id_1',
    ),
  ),
  PostIt.initialize(
    uid: 'uid_2',
    title: 'Test Post It 2',
    description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500',
    mbti: 'INTP',
    hobbies: ['Music', 'Photo', 'Movie', 'Book', 'Game', 'Travel', 'Coffee'],
    topics: ['Computer Science', 'Junior'],
    snsIds: SnsIds.initialize(
      instagram: 'instagram_id_2',
      facebook: 'facebook_id_2',
      kakaotalk: 'kakaotalk_id_2',
    ),
  ),
  PostIt.initialize(
    uid: 'uid_3',
    title: 'Test Post It 3',
    description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500',
    mbti: 'ENTJ',
    hobbies: ['Music', 'Photo', 'Movie', 'Book', 'Game', 'Travel', 'Coffee'],
    topics: ['Computer Science', 'Junior'],
    snsIds: SnsIds.initialize(
      instagram: 'instagram_id_3',
      facebook: 'facebook_id_3',
      kakaotalk: 'kakaotalk_id_3',
    ),
  ),
];