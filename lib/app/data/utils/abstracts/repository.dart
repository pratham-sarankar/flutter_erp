abstract class Repository<T> {
  Future insert(T value);
  Future<List<T>> fetch({int? limit, int? offset});
  Future<T> fetchOne(int id);
  Future update(T value);
  Future destroy(T value);
  Future destroyMany(List<T> value);
}
