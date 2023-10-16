import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고 데이터
class SessionUser {
  String? jwt;
  bool isLogin;

  SessionUser({this.isLogin = false});
}

// 2. 창고
// 상태 변경이 없으므로 필요 없다!!!

// 3. 창고 관리자
// Provider는 화면 갱신이 안된다.
// 전역적 변수는 static으로 해도 되지만, 그냥 Provider로 관리하자.(컨벤션)
final sessionProvider = Provider<SessionUser>(
  (ref) {
    return SessionUser();
  },
);
