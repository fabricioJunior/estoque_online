import 'package:core/datasources/local/hive/local_datasource_base.dart';
import 'package:core/datasources/local/hive/storage_entity_adapter.dart';
import 'package:core/datasources/local_dtos.dart';
import 'package:siv_codebar/domain/models/produto.dart';

class ProdutosLocalDatasource extends HiveLocalDatasourceBase<Produto, String> {
  @override
  String boxName(Map<String, dynamic>? args) {
    return 'produtos';
  }

  @override
  String key(Produto entity) {
    return entity.codigoDeBarras;
  }

  @override
  List<StorageEntityAdapter<StorageEntity>> get adapters =>
      [StorageEntityAdapter<Produto>(Produto.fromJson)];
}
