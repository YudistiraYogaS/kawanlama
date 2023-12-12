import 'package:drift/drift.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/domain/reponses/item_responses.dart';
import 'package:kawanlama/infrastructure/core/database_module/database_module.dart';
import 'package:kawanlama/utilities/utilities.dart';

class ItemMapper {
  ItemMapper._();

  static List<ItemDTO> itemFromResponses(List<ItemResponses> response) {
    return response
        .map((e) => ItemDTO(
            id: generateId(),
            name: e.nama ?? '',
            description: (e.keterangan ?? '').replaceAll('<i>', '_').replaceAll('<\/i>', "_"),
            audioUrl: e.audio ?? '',
            number: int.parse(e.nomor ?? "0"),
            type: e.type ?? '',
            mean: e.arti ?? '',
            isFavorite: false))
        .toList();
  }

  static Insertable<Favorite> favoriteFromItemDTO(ItemDTO data) {
    return FavoritesCompanion(
      sourceId: Value(data.id),
      name: Value(data.name),
      description: Value(data.description),
      audioUrl: Value(data.audioUrl),
      number: Value(data.number),
      type: Value(data.type),
      mean: Value(data.mean),
      isFavorite: const Value(true),
    );
  }

  static List<ItemDTO> itemFromDao(List<Favorite> data) {
    return data
        .map((e) => ItemDTO(
              id: e.sourceId,
              name: e.name ?? '',
              description: e.description ?? '',
              audioUrl: e.audioUrl ?? '',
              number: e.number ?? 0,
              type: e.type ?? '',
              mean: e.mean ?? '',
              isFavorite: e.isFavorite,
            ))
        .toList();
  }
}
