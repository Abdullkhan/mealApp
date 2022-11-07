import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/repository/popular_products_repo.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:get/get.dart';

class PopularProductsController extends GetxController {
  final PopularProductsRepo popularProductsRepo;

  PopularProductsController({
    required this.popularProductsRepo,
  });

  late CartController _cart;

  List<ProductsModel> _popularProductsList = [];
  List<ProductsModel> get popularProductsList {
    return [..._popularProductsList];
  }

  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  int _quantity = 0;
  int get quantity {
    return _quantity;
  }

  int _inCartItems = 0;
  int get inCartItems {
    return _inCartItems + _quantity;
  }

  Future<void> getPopularProductsList() async {
    Response response = await popularProductsRepo.getPopularProductsList();
    if (response.statusCode == 200) {
      // print('getting the response ');
      _popularProductsList = [];
      _popularProductsList.addAll(Product.fromJson(response.body).products);
      //print('the response is printed as' + _popularProductsList.toString());
      _isLoading = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      print('it is addding');
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar('Alert', 'You cannot decrease more');
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if (quantity > 25) {
      Get.snackbar('Alert', 'You cannot increase more');
      return 25;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductsModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exist = false;

    exist = _cart.existInCart(product);

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItems(ProductsModel product) {
    _cart.addItems(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print('the id is ' +
          value.id.toString() +
          'The quantity is ' +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cart.totalCartItems;
  }

  List<CartModel> get getitemsforCartPage {
    return _cart.getItemsforCartPage;
  }
}
