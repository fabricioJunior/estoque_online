abstract class IDto<TypeId> {
  TypeId get dataBaseId;

  void loadLazyLoadeds();
}
