// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dao.dart';

// ignore_for_file: type=lint
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  Selectable<int> countAll() {
    return customSelect(
      'SELECT COUNT(*) AS _c0 FROM users',
      variables: [],
      readsFrom: {users},
    ).map((QueryRow row) => row.read<int>('_c0'));
  }
}
