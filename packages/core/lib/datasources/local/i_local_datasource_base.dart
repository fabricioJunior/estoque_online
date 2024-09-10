abstract class ILocalDatasourceBase<E, Key> {
  Future<Iterable<E>> fetchAll();

  Future<Iterable<E>> fetchWhere(dynamic test, [anyArgument]);

  Future<E?> fetch(Key key);

  Future<bool> delete(E entity);

  Future<void> deleteWithKey(
    Key key,
  );

  Future<void> deleteWhere({
    dynamic test,
  });

  Future<void> clearStorage();

  Future<E> put(E entity);

  Future<void> putAll(Iterable<E> iterable, [dynamic anyArgument]);
}
