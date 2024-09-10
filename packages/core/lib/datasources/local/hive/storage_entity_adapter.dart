import 'package:core/datasources/local/hive/storage_entity.dart';
import 'package:hive/hive.dart';
import 'entities_controller.dart' as entity_controllers;

class StorageEntityAdapter<E extends StorageEntity> extends TypeAdapter<E> {
  StorageEntityAdapter(
    this.buildEntity, {
    this.typeCode,
  });

  final E Function(Map<String, dynamic> props) buildEntity;
  final int? typeCode;

  void registerHiveAdapterWithType() {
    if (Hive.isAdapterRegistered(typeCode ?? typeId)) {
      return;
    }
    Hive.registerAdapter<E>(
      this,
      override: true,
    );
  }

  @override
  void write(BinaryWriter writer, E obj) {
    var props = obj.storageProperties;

    writer.writeInt(props.length);

    for (final String prop in props.keys) {
      writer
        ..writeString(prop)
        ..write(
          (props[prop]),
        );
    }
  }

  @override
  E read(BinaryReader reader) {
    final numOfProperties = reader.readInt();
    final props = <String, dynamic>{
      for (int i = 0; i < numOfProperties; i++)
        reader.readString(): reader.read(),
    };
    return buildEntity.call(props);
  }

  @override
  int get typeId => typeCode ?? entity_controllers.typeId(E);

  Type get type => E;
}
