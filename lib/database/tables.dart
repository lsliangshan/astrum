import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

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

@DataClassName('Message')
class Messages extends Table {
  // 消息 ID
  TextColumn get id => text()();
  // 智能体 ID
  TextColumn get roleId => text()();
  // 消息内容
  TextColumn get content => text()();
  // 消息发送者 ID
  TextColumn get senderId => text().nullable()();
  // 消息发送者名称
  TextColumn get senderName => text().nullable()();
  // 消息发送者头像
  TextColumn get senderAvatar =>
      text().nullable().withDefault(const Constant(''))();
  // 消息发送时间
  TextColumn get createAt => text().nullable().withDefault(
    Constant(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())),
  )();
  // 消息类型，text、image、voice、video
  TextColumn get type =>
      text().nullable().withDefault(const Constant('text'))();
  // 消息是否是机器人发送的
  BoolColumn get isRobot =>
      boolean().nullable().withDefault(const Constant(false))();
  // 消息状态，success、failed、sending
  TextColumn get status =>
      text().nullable().withDefault(const Constant('success'))();

  @override
  Set<Column> get primaryKey => {id};
}

// 智能体
@DataClassName('User')
class Users extends Table {
  // 用户 ID
  TextColumn get id => text()();
  // 用户名
  TextColumn get username => text()();
  // 密码
  TextColumn get password => text()();
  // 手机号
  TextColumn get phonenum => text().nullable()();
  // 昵称
  TextColumn get nickname => text().nullable()();
  // 邮箱
  TextColumn get email => text().nullable()();
  // 用户 token
  TextColumn get token => text().nullable()();
  // 头像
  TextColumn get avatar => text().nullable()();
  // 性别，male：男，female：女
  TextColumn get gender =>
      text().nullable().withDefault(const Constant('male'))();
  // 生日
  TextColumn get birthday => text().nullable()();
  // 个性签名
  TextColumn get signature => text().nullable()();
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
