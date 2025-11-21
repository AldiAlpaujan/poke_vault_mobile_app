abstract class UseCase<T, Request> {
  Future<T> call({Request request});
}
