import 'package:core/datasources/hive.dart';
import 'package:hive/hive.dart';

import '../i_local_datasource_base.dart';
import 'storage_entity_adapter.dart';

abstract class HiveLocalDatasourceBase<E extends StorageEntity, Key>
    implements ILocalDatasourceBase<E, Key> {
  Future<Box<E>> _openBox(Map<String, dynamic>? argsToBoxName) async {
    var name = boxName(argsToBoxName);
    _registerAdpaters();

    try {
      return await Hive.openBox<E>(
        name,
        compactionStrategy: (_, deletedEntries) {
          return deletedEntries > 50;
        },
      );
    } catch (e) {
      if (Hive.isBoxOpen(name)) {
        var box = Hive.box(name);
        await box.close();
      }
    } finally {
      await Hive.deleteBoxFromDisk(name);
    }
    return await Hive.openBox<E>(
      name,
      compactionStrategy: (_, deletedEntries) {
        return deletedEntries > 50;
      },
    );
  }

  void _registerAdpaters() {
    for (var adapter in adapters) {
      adapter.registerHiveAdapterWithType();
    }
  }

  @override
  Future<void> clearStorage([Map<String, dynamic>? argsToBoxName]) async {
    var box = await _openBox(argsToBoxName);
    await box.clear();
  }

  Future<void> deleteBox([Map<String, dynamic>? argsToBoxName]) async {
    await Hive.deleteBoxFromDisk(boxName(argsToBoxName));
  }

  @override
  Future<bool> delete(E entity, [Map<String, dynamic>? argsToBoxName]) async {
    var box = await _openBox(argsToBoxName);
    // ignore: no_leading_underscores_for_local_identifiers
    var _key = key(entity);
    if (box.containsKey(_key)) {
      await box.delete(_key);
      return true;
    }
    return false;
  }

  @override
  Future<void> deleteWithKey(
    Key key, [
    Map<String, dynamic>? argsToBoxName,
  ]) async {
    var box = await _openBox(argsToBoxName);
    await box.delete(key);
  }

  @override
  Future<Iterable<E>> fetchAll([Map<String, dynamic>? argsToBoxName]) async {
    var box = await _openBox(argsToBoxName);

    return box.values;
  }

  @override
  Future<E?> fetch(Key key, [Map<String, dynamic>? argsToBoxName]) async {
    var box = await _openBox(argsToBoxName);
    return box.get(key);
  }

  @override
  Future<E> put(E entity, [argsToBoxName]) async {
    var box = await _openBox(argsToBoxName);
    await box.put(key(entity), entity);
    return entity;
  }

  String boxName(Map<String, dynamic>? args);

  List<StorageEntityAdapter> get adapters;

  Key key(E entity);

  @override
  Future<void> deleteWhere({
    dynamic test,
    Map<String, dynamic>? argsToBoxName,
  }) async {
    var box = await _openBox(argsToBoxName);

    var entities = box.values.where(test);

    var keys = entities.map((e) => key(e));

    return await box.deleteAll(keys);
  }

  @override
  Future<Iterable<E>> fetchWhere(test, [argsToBoxName]) async {
    var box = await _openBox(argsToBoxName);

    return box.values.where(test);
  }

  @override
  Future<void> putAll(Iterable<E> iterable, [argsToBoxName]) async {
    var box = await _openBox(argsToBoxName);

    return box.putAll(Map.fromIterable(
      iterable,
      key: (e) => key(e),
    ));
  }
}
