import 'package:dio/dio.dart';
import 'package:kawanlama/domain/constant/app_strings.dart';
import 'package:kawanlama/domain/reponses/item_responses.dart';
import 'package:retrofit/retrofit.dart';

part 'i_data_source.g.dart';

@RestApi(baseUrl: AppStrings.baseUrl)
abstract class IDataSource {
  factory IDataSource(Dio dio, {String baseUrl}) = _IDataSource;

  @GET(AppStrings.dataUrl)
  Future<List<ItemResponses>> getData();
}