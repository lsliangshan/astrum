import 'package:astrum/database/database.dart';
import 'package:astrum/database/tables.dart';
import 'package:drift/drift.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

part 'user.dao.g.dart';

@DriftAccessor(
  tables: [Users],
  queries: {'countAll': 'SELECT COUNT(*) FROM users;'},
)
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  // 构造方法是必需的，这样主数据库可以创建这个对象的实例。
  // ignore: use_super_parameters
  UserDao(AppDatabase db) : super(db);

  bool isExpired({required String id, required String token}) {
    bool expired = false;
    try {
      final jwt = JWT.verify(token, SecretKey('liangqy.com'));
      int exp = jwt.payload['exp'] as int;
      if ((exp * 1000 < DateTime.now().millisecondsSinceEpoch) ||
          jwt.payload['data'] == null ||
          jwt.payload['data']['id'] != id) {
        expired = true;
      } else {
        expired = false;
      }
    } on JWTExpiredException {
      expired = true;
    } on JWTException catch (_) {
      expired = true;
    }
    return expired;
  }

  Future<User> getLoginInfo() async {
    final user =
        await (select(users)
              ..where((tbl) => tbl.token.isNotNull())
              ..limit(1))
            .getSingleOrNull();

    if (user == null || user.token == null || user.token!.isEmpty) {
      return User(id: '', username: '', password: '', token: '');
    }
    if (isExpired(id: user.id, token: user.token!)) {
      return User(id: '', username: '', password: '', token: '');
    }

    return user;
  }

  Future<User> login({required User user}) async {
    final localUser =
        await (select(users)
              ..where((tbl) => tbl.token.isNotNull())
              ..limit(1))
            .getSingleOrNull();
    if (localUser == null) {
      // 用户不存在
      await into(users).insert(
        UsersCompanion(
          id: Value(user.id),
          username: Value(user.username),
          password: Value(user.password),
          token: Value(user.token),
          phonenum: Value(user.phonenum),
          nickname: Value(user.nickname),
          email: Value(user.email),
          avatar: Value(user.avatar),
          gender: Value(user.gender ?? 'male'),
          birthday: Value(user.birthday),
          signature: Value(user.signature),
          createAt: Value(DateTime.now().millisecondsSinceEpoch.toString()),
          updateAt: Value(DateTime.now().millisecondsSinceEpoch.toString()),
          tokens: Value(user.tokens ?? 0),
          vipType: Value(user.vipType ?? 'free'),
          vipStart: Value(user.vipStart ?? ''),
          vipEnd: Value(user.vipEnd ?? ''),
        ),
      );
    } else {
      // 用户存在
      await (update(users)..where((tbl) => tbl.id.equals(user.id))).write(
        UsersCompanion(token: Value(user.token)),
      );
    }
    return (select(users)..where((tbl) => tbl.id.equals(user.id))).getSingle();
  }

  Future<void> updateUserTokens({
    required String userId,
    required int tokens,
  }) async {
    await (update(users)..where((tbl) => tbl.id.equals(userId))).write(
      UsersCompanion(tokens: Value(tokens)),
    );
  }

  Future<int> logout(String id) {
    return (delete(users)..where((u) => u.id.equals(id))).go();
  }
}
