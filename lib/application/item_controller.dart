import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/domain/interface/i_item_data_source.dart';
import 'package:kawanlama/utilities/utilities.dart';

@lazySingleton
class ItemController extends GetxController {
  final IItemDataSource _itemRepository;

  ItemController(this._itemRepository);

  /// obs variable
  final RxList<ItemDTO> items = <ItemDTO>[].obs;

  /// function
  Future<void> fetchItem() async {
    try {
      items([]);
      final data = await _itemRepository.getItems();
      items(data);
    } catch (e) {
      rethrow;
    }
  }
}
