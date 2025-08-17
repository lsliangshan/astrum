import 'package:astrum/database/database.dart';
import 'package:astrum/database/tables.dart';
import 'package:astrum/models/normal_response.model.dart';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

part 'role.dao.g.dart';

@DriftAccessor(
  tables: [Roles],
  queries: {'countAll': 'SELECT COUNT(*) FROM roles;'},
)
class RoleDao extends DatabaseAccessor<AppDatabase> with _$RoleDaoMixin {
  // 构造方法是必需的，这样主数据库可以创建这个对象的实例。
  // ignore: use_super_parameters
  RoleDao(AppDatabase db) : super(db);

  Future<int> createRole({
    required String id,
    required String name,
    String? description,
    String? icon,
    String? authorId,
    String? authorName,
    String? publishTime,
    String? updateAt,
    String? createAt,
    bool? isForked,
  }) {
    return into(roles).insertOnConflictUpdate(
      RolesCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description ?? ''),
        icon: Value(icon ?? ''),
        authorId: Value(authorId ?? ''),
        authorName: Value(authorName ?? ''),
        publishTime: Value(publishTime ?? ''),
        updateAt: Value(
          updateAt ?? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        ),
        createAt: Value(
          createAt ?? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        ),
        isForked: Value(isForked ?? false),
      ),
    );
  }

  Future<int> insertAll({required List<Role> roleList}) async {
    final result = await Future.wait(
      roleList.map(
        (e) => createRole(
          id: e.id,
          name: e.name,
          description: e.description,
          icon: e.icon,
          authorId: e.authorId,
          authorName: e.authorName,
          publishTime: e.publishTime,
          updateAt: e.updateAt,
          createAt: e.createAt,
          isForked: e.isForked,
        ),
      ),
    );
    return Future.value(result.length);
  }

  Future<int> updateRole({
    required String id,
    String? name,
    String? description,
    String? icon,
    String? authorId,
    String? authorName,
    String? publishTime,
    String? updateAt,
    bool? isForked,
  }) {
    if (name != null) {
      return (update(roles)..where((role) => role.id.equals(id))).write(
        RolesCompanion(name: Value(name)),
      );
    }
    return (update(roles)..where((role) => role.id.equals(id))).write(
      RolesCompanion(
        description: Value(description ?? ''),
        icon: Value(icon ?? ''),
        authorId: Value(authorId ?? ''),
        authorName: Value(authorName ?? ''),
        publishTime: Value(publishTime ?? ''),
        updateAt: Value(updateAt ?? ''),
        isForked: Value(isForked ?? false),
      ),
    );
  }

  Future<int> forkRole({required Role role}) async {
    return into(
      roles,
    ).insertOnConflictUpdate(role.copyWith(isForked: Value(true)));
  }

  Future<int> unforkRole({required Role role}) async {
    return (delete(roles)..where((tbl) => tbl.id.equals(role.id))).go();
  }

  Future<NormalResponse> getRoles({
    String? authorId,
    int? pageIndex = 1,
    int? pageSize = 20,
  }) async {
    int totalCount = await (select(roles)).get().then((value) => value.length);
    int totalPage = (totalCount / pageSize!).ceil();

    int countInLastPage = totalCount % pageSize;

    int offset = (totalPage - pageIndex!) > 0
        ? (totalPage - pageIndex - 1) * pageSize + countInLastPage
        : 0;

    final roleList =
        await (select(roles)
              // ..where((role) => role.authorId.equals(authorId ?? ''))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.createAt)])
              ..limit(pageSize, offset: offset))
            .get();

    return NormalResponse(
      code: 200,
      data: {
        'list': roleList,
        'totalCount': totalCount,
        'totalPage': totalPage,
        'pageIndex': pageIndex,
        'pageSize': pageSize,
      },
      message: 'success',
    );
  }

  Future<void> deleteMyRoles({required String authorId}) async {
    await (delete(roles)..where((role) => role.authorId.equals(authorId))).go();
  }

  Future<Role?> getRoleDetail({required String roleId}) async {
    final response = await (select(
      roles,
    )..where((role) => role.id.equals(roleId))).getSingleOrNull();
    return response;
  }
}
