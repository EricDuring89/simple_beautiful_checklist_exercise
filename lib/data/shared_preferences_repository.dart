import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  SharedPreferences? _prefs;
  List<String> _items = [];

  Future<void> initializePersistence() async {
    _prefs = await SharedPreferences.getInstance();
    _items = _prefs?.getStringList("_items") ?? [];
  }

  @override
  Future<void> addItem(String item) {
    _items.add(item);
    return _prefs!.setStringList("_items", _items);
  }

  @override
  Future<void> deleteItem(int index) async {
    _items.removeAt(index);
    _prefs?.setStringList("_items", _items);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    if (newItem.isNotEmpty && !_items.contains(newItem)) {
      _items[index] = newItem;
    }
    _prefs?.setStringList("_items", _items);
  }

  @override
  Future<int> getItemCount() async {
    return _items.length;
  }

  @override
  Future<List<String>> getItems() async {
    _items = _prefs?.getStringList("_items") ?? [];
    return _items;
  }
}
