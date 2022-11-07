import 'package:food_delivery_app/models/products_model.dart';
import 'package:get/get.dart';
import '../data/repository/recommended_products_repo.dart';

class RecommendedProductsController extends GetxController {
  final RecommendedProductRepo recommendedProductsRepo;

  RecommendedProductsController({required this.recommendedProductsRepo});

  List<ProductsModel> _recommendedProductList = [];
  List<ProductsModel> get recommendedProductList {
    return [..._recommendedProductList];
  }

  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductsRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print('repsonse recommendedProducts');
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoading = true;
      update();
    } else {
      print('else part is working only');
    }
  }
}
