// 1. 창고 데이터(Model)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_repository.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

class PostModel {
  int id;
  int userId;
  String title;

  PostModel(this.id, this.userId, this.title);

  // 이것도 생성자임.
  PostModel.fromJson(Map<String, dynamic> json)
      // 이니셜 라이저 사용
      : id = json["id"],
        userId = json["userId"],
        title = json["title"];
}

// 2. 창고(View Model)
class PostViewModel extends StateNotifier<PostModel?> {
  // 생성자를 통해 상태를 부모에게 전달
  PostViewModel(super.state, this.ref);

  Ref ref;

  // 상태 초기화 (필수!!!!!!!!!!!!)
  void init() async {
    // 통신 코드
    PostModel postModel = await PostRepository().fetchPost(40);
    state = postModel;
  }

  // 상태 변경 (로그인 했을때? 안했을때?)
  void change() async {
    SessionUser sessionUser = ref.read(sessionProvider);

    if (sessionUser.isLogin) {
      PostModel postModel = await PostRepository().fetchPost(50);
      state = postModel;
    }
  }
}

// 3. 창고 관리자(Provider)
// 창고 관리자는 View(화면)한테 PostViewModel을 전달해주면 된다.
// provider가 만들어질때, 창고도 만들어진다.
final postProvider =
    StateNotifierProvider.autoDispose<PostViewModel, PostModel?>(
  (ref) {
    return PostViewModel(null, ref)..init();
  },
);
