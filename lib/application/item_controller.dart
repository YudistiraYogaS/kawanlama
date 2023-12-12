import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/domain/interface/i_auth.dart';
import 'package:kawanlama/domain/interface/i_item_data_source.dart';
import 'package:kawanlama/domain/mapper/item_mapper.dart';
import 'package:kawanlama/infrastructure/core/database_module/dao/favorite_dao.dart';
import 'package:kawanlama/utilities/pdf_utillities.dart';

@lazySingleton
class ItemController extends GetxController {
  final IItemDataSource _itemRepository;
  final IAuth _authRepository;
  final FavoritesDao _favoritesDao;

  ItemController(this._itemRepository, this._favoritesDao, this._authRepository);

  /// obs variable
  final RxList<ItemDTO> items = <ItemDTO>[].obs;
  final RxList<ItemDTO> favoritesItems = <ItemDTO>[].obs;

  /// function
  Future<void> fetchItem() async {
    try {
      items([]);
      final data = await _itemRepository.getItems();
      await getFavorites();
      final List<ItemDTO> itemWithFavorites = [];
      for (var element in data) {
        /// using name because id always regenerated every fetch
        if (favoritesItems.where((e) => e.name == element.name && e.user == _authRepository.userLoggedIn()).isNotEmpty) {
          itemWithFavorites.add(element.copyWith(true, users: _authRepository.userLoggedIn()));
        } else {
          itemWithFavorites.add(element.copyWith(false, users: _authRepository.userLoggedIn()));
        }
      }
      items(itemWithFavorites);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAsFavorite(ItemDTO data) async {
    try {
      /// using name because id always regenerated every fetch
      final modifiedItem = items
          .toList()
          .map((element) => (element.id == data.id || element.name == data.name) ? element.copyWith(true, users: _authRepository.userLoggedIn()) : element)
          .toList();
      await _favoritesDao.insertFavorite(ItemMapper.favoriteFromItemDTO(data, _authRepository.userLoggedIn()));
      items(modifiedItem);
      await getFavorites();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getFavorites() async {
    try {
      final data = await _favoritesDao.getAllFavorites(_authRepository.userLoggedIn());
      favoritesItems(ItemMapper.itemFromDao(data));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFavorite(ItemDTO data) async {
    try {
      /// using name because id always regenerated every fetch
      final modifiedItem = items.toList().map((element) => (element.id == data.id || element.name == data.name) ? element.copyWith(false) : element).toList();
      await _favoritesDao.deleteFavoriteById(data.id, _authRepository.userLoggedIn());
      await getFavorites();
      items(modifiedItem);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> print() async {
    try {
      final doc = await createPDF(favoritesItems);
      await printingDocument(doc);
    } catch (e) {
      rethrow;
    }
  }
}
