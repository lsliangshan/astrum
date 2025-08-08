import 'package:drift/drift.dart';

// 智能体
@DataClassName('Role')
class Roles extends Table {
  // 智能体 ID
  TextColumn get id => text()();
  // 智能体 名称
  TextColumn get name => text()();
  // 智能体 描述
  TextColumn get description => text().nullable().withDefault(Constant(''))();
  // 智能体 图标
  TextColumn get icon => text().nullable()();

  // 作者 ID
  TextColumn get authorId => text().nullable()();
  // 作者 名称
  TextColumn get authorName => text().nullable()();
  // 发布时间
  TextColumn get publishTime => text().nullable().withDefault(
    Constant(DateTime.now().millisecondsSinceEpoch.toString()),
  )();
  // 更新时间
  TextColumn get updateAt => text().nullable().withDefault(
    Constant(DateTime.now().millisecondsSinceEpoch.toString()),
  )();
  // 创建时间
  TextColumn get createAt => text().nullable().withDefault(
    Constant(DateTime.now().millisecondsSinceEpoch.toString()),
  )();

  @override
  Set<Column> get primaryKey => {id};
}

// 智能体
@DataClassName('Attachment')
class Attachments extends Table {
  // 附件 ID
  TextColumn get id => text()();
  // 附件 名称
  TextColumn get filename => text()();
  // 附件 链接
  TextColumn get url => text()();
  // 智能体 ID
  TextColumn get roleId => text().nullable()();
  // 智能体 名称
  TextColumn get roleName => text().nullable()();
  // 更新时间
  TextColumn get updateAt => text().nullable().withDefault(
    Constant(DateTime.now().millisecondsSinceEpoch.toString()),
  )();
  // 创建时间
  TextColumn get createAt => text().nullable().withDefault(
    Constant(DateTime.now().millisecondsSinceEpoch.toString()),
  )();

  @override
  Set<Column> get primaryKey => {id};
}

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement().nullable()();
}
