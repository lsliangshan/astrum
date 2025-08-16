// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dao.dart';

// ignore_for_file: type=lint
mixin _$RoleDaoMixin on DatabaseAccessor<AppDatabase> {
  $RolesTable get roles => attachedDatabase.roles;
  Selectable<int> countAll() {
    return customSelect(
      'SELECT COUNT(*) AS _c0 FROM roles',
      variables: [],
      readsFrom: {roles},
    ).map((QueryRow row) => row.read<int>('_c0'));
  }
}
