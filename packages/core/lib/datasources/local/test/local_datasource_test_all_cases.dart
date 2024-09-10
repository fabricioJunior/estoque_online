// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:core/datasources/local/i_dto.dart';
import 'package:core/datasources/local/test/storage_wrapper_to_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../i_local_datasource.dart';

class LocalDatasourceTestAllCases<Dto extends IDto, Key, Storage> {
  final ILocalDatasource<Dto, Key> Function(Storage storage)
      onGetlocalDatasource;
  final StorageWrapperToTest<Dto, dynamic, Storage> storageWrapper;

  late ILocalDatasource localDatasource;

  LocalDatasourceTestAllCases({
    required this.onGetlocalDatasource,
    required this.storageWrapper,
  });

  void _init(Storage storage) {
    localDatasource = onGetlocalDatasource(storage);
  }

  Future<void> init() async {
    _init(await storageWrapper.init());
  }

  Future<void> testPut(Dto dto) async {
    var storage = await storageWrapper.init();
    _init(storage);
    print(
        '${localDatasource.runtimeType} armazena ${dto.runtimeType} no storage');

    await localDatasource.put(dto);
    var result = await storageWrapper.fetch(dto.dataBaseId);
    expect(
      result,
      dto,
      reason:
          'ao realizara a busca no storage não foi o retornado o mesmo ${dto.runtimeType}',
    );

    // test(
    //   ,
    //   () async {

    // );
  }

  Future<void> testPutAll(Iterable<Dto> dtos) async {
    var storage = await storageWrapper.init();
    _init(storage);
    print(
        '${localDatasource.runtimeType} armazena ${dtos.runtimeType}s no storage');
    await localDatasource.putAll(dtos);

    expect(await storageWrapper.fetchAll(), dtos,
        reason:
            'ao realizara a busca no storage não foi o retornada o mesmo ${dtos.runtimeType}');
  }

  Future<void> testDeleteAll(int databaseDividerId, Iterable<Dto> dtos) async {
    var storage = await storageWrapper.init();
    _init(storage);
    print(
        '${localDatasource.runtimeType} deleta todos os ${dtos.runtimeType}s no storage');
    await storageWrapper.setupStorage(dtos);

    await localDatasource.deleteAll(
      databaseDividerId: databaseDividerId,
    );

    expect(
      await storageWrapper.fetchAll(),
      [],
      reason: 'ao realizara a busca no storage não foi encontrado vazio',
    );
  }

  Future<void> testDelete(
    Dto dto,
    Iterable<Dto> dtos,
  ) async {
    var storage = await storageWrapper.init();
    _init(storage);
    await storageWrapper.setupStorage(dtos);

    await localDatasource.delete(dto);

    expect(await storageWrapper.fetch(dto.dataBaseId), null,
        reason:
            'ao realizara a busca no storage a inda foi encontrado um ${dtos.runtimeType}');
  }

  //   if (Isar.getInstance('operatos_local_data_source') == null) {
  //     isarInstance = await Isar.open(
  //       [OperatorDtoSchema],
  //       directory: '.isar',
  //       name: 'operatos_local_d
  // void _setupStorage() async {
  //   var directory = Directory('.isar');
  //   if (!directory.existsSync()) {
  //     await directory.create(recursive: true);
  //   }ata_source',
  //     );
  //     await isarInstance.writeTxn(
  //       () async {
  //         await isarInstance.operatorDtos.clear();
  //         return null;
  //       },
  //     );
  //   }

  //   operatorsLocalDatasource = OperatorsLocalDatasource(
  //     onGetIsar: onGetIsar,
  //   );
  // }
}
