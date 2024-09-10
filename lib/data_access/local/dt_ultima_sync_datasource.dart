import 'package:core/datasources/local/hive/local_datasource_base.dart';
import 'package:core/datasources/local/hive/storage_entity_adapter.dart';
import 'package:core/datasources/local_dtos.dart';

class DtUltimaSyncDatasource extends HiveLocalDatasourceBase<SyncData, String> {
  @override
  List<StorageEntityAdapter<StorageEntity>> get adapters => [
        StorageEntityAdapter<SyncData>(SyncData.fromStorage),
      ];

  @override
  String boxName(Map<String, dynamic>? args) {
    return 'sync_control';
  }

  @override
  String key(SyncData entity) {
    return entity.nome;
  }
}

class SyncData extends StorageEntity {
  final String nome;
  final DateTime? data;

  SyncData({required this.nome, required this.data});

  @override
  Map<String, dynamic> get storageProperties => {
        'nome': nome,
        'data': data,
      };

  SyncData.fromStorage(Map<String, dynamic> props)
      : nome = props['nome'],
        data = props['data'];
}
