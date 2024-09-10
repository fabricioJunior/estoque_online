import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Map<Type, int>? _storageTypes;

int typeId(Type type) {
  if (_storageTypes != null) {
    if (_storageTypes!.containsKey(type)) {
      return _storageTypes![type]!;
    } else {
      throw NotRegisterTypeExcepetion(type);
    }
  } else {
    throw UninitializedStorageExcepetion();
  }
}

Future<void> inicializarStorage(
  Map<Type, int> storageTypes,
) async {
  final localDir = await getApplicationDocumentsDirectory();
  var dir = Directory('${localDir.path}/mentor.hive');

  Hive.init(dir.path);
  _verificarIndentificadores(storageTypes);
  //_verificarTiposDuplicados(storageTypes);
  _storageTypes = storageTypes;
}

void _verificarIndentificadores(Map<Type, int> storageTypes) {
  var numeroDeIndentificadores = storageTypes.values.length;
  var numeroDeIndentificadoresDistintos = storageTypes.values.toSet().length;

  if (numeroDeIndentificadores != numeroDeIndentificadoresDistintos) {
    AssertionError(
      '''Existem tipos com indentificadores iguais, verifique os Ids
            adicionados no mapeamento de entidades armazenaveis no cache''',
    );
  }
}

bool isSubtype<S, T>() => <S>[] is List<T>;

class InvalidTypeExcepetion extends FormatException {
  InvalidTypeExcepetion(Type type)
      : super(
          '${type.toString()} não é uma entidade armazenavel',
        );
}

class NotRegisterTypeExcepetion extends FormatException {
  NotRegisterTypeExcepetion(Type type)
      : super(
          '${type.toString()} não está registrado como uma entidade armazenavel',
        );
}

class UninitializedStorageExcepetion extends FormatException {
  UninitializedStorageExcepetion()
      : super(
          '''O storage não foi inicializado, chame StorageController.inicializarStorage()
                                              antes de armazena ou ler qualquer informação ''',
        );
}
