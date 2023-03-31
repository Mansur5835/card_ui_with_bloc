import 'package:hive/hive.dart';

enum BoxKeys { listOfGradientModels, listOfBackImages, listOfCards }

class LocalStorage<T> {
  static const String BOX_NAME = 'local_storage_name';
  static final Box _box = Hive.box(BOX_NAME);

  Future<void> writeData(BoxKeys boxKeys, T data) async {
    await _box.put(boxKeys.toString(), data);
  }

  T? readData<T>(BoxKeys boxKeys) {
    return _box.get(boxKeys.toString());
  }

  Future<void> deleteData(BoxKeys boxKeys) async {
    await _box.delete(boxKeys.toString());
  }
}
