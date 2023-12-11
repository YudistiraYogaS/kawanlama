import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/domain/reponses/item_responses.dart';
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
}
