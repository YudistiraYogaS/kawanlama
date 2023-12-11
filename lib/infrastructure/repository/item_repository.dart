import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/dto/item_dto.dart';
import 'package:kawanlama/domain/interface/data_source/i_data_source.dart';
import 'package:kawanlama/domain/interface/i_item_data_source.dart';
import 'package:kawanlama/domain/mapper/item_mapper.dart';

@LazySingleton(as: IItemDataSource)
class ItemRepository implements IItemDataSource {
  final Dio _dio;
  late IDataSource _retrofit;

  ItemRepository(this._dio) {
   _retrofit = IDataSource(_dio);
  }

  @override
  Future<List<ItemDTO>> getItems() async {
    try {
      final data = await _retrofit.getData();
      return ItemMapper.itemFromResponses(data);
    } catch (e) {
      rethrow;
    }
  }

}