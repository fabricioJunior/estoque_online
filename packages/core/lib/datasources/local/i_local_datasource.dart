import 'package:core/datasources/local/i_local_datasource_base.dart';

abstract class ILocalDatasource<E, Key>
    implements ILocalDatasourceBase<E, Key> {
  @override
  Future<E> put(
    E entity,
  );

  @override
  Future<E?> fetch(Key key);

  @override
  Future<Iterable<E>> fetchWhere(dynamic test, [anyArgument]);

  Future<void> deleteAll({int? databaseDividerId});
}
