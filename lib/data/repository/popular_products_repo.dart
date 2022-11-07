import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utilities/app_constants.dart';
import 'package:get/get.dart';

class PopularProductsRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductsRepo({
    required this.apiClient,
  });

  Future<Response> getPopularProductsList() async {
    return await apiClient.getData(AppConstants.popularProductUri);
  }
}
