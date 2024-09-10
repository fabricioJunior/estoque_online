abstract class StorageWrapperToTest<Dto, Key, Storage> {
  Future<Storage> init();

  Future<void> setupStorage(
    Iterable<Dto> dtos,
  );

  Future<Dto?> fetch(Key key);

  Future<Iterable<Dto>> fetchAll();
}
