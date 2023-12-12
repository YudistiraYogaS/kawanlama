import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/domain/mapper/item_mapper.dart';
import 'package:kawanlama/infrastructure/core/database_module/database_module.dart';
import 'package:kawanlama/infrastructure/core/database_module/database_table/favorite_table.dart';

part 'favorite_dao.g.dart';

// the _FavoritesDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <MyDatabase> type annotation is the database class
// that should use this dao.
@LazySingleton()
@DriftAccessor(tables: [Favorites])
class FavoritesDao extends DatabaseAccessor<MyDatabase> with _$FavoritesDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  FavoritesDao(MyDatabase db) : super(db);

  Future<List<Favorite>> getAllFavorites(String user) async => await (select(favorites)..where((t) => t.user.equals(user))).get();

  Future insertFavorite(Insertable<Favorite> favorite) async => await into(favorites).insert(favorite);

  Future deleteFavoriteById(String id, String user) async => await db.customStatement("DELETE FROM Favorites where source_id = ? and user = ?", [id, user]);

  Future insertTransaction(List<ItemDTO> data, String user) async => await db.transaction(() async {
        for (var item in data) {
          await insertFavorite(ItemMapper.favoriteFromItemDTO(item, user));
        }
      });
}
