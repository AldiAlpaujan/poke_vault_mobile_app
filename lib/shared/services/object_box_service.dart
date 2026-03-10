import 'package:poke_vault_mobile_app/objectbox.g.dart';

class ObjectBoxService {
  static late final Store _store;

  static Future<void> init() async {
    _store = await openStore();
  }

  static Box<T> box<T>() => Box<T>(_store);
}
