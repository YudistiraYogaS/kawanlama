import 'package:kawanlama/domain/dto/item_dto.dart';

abstract interface class IItemDataSource {
  Future<List<ItemDTO>> getItems();
}