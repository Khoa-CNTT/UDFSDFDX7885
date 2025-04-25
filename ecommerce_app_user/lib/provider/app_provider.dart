import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore.dart';

import 'package:ecommerce_app_user/models/product_model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecommerce_app_user/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  // User
  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;

  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  // Favorite Products
  List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  // Cart
  List<ProductModel> _cartProductList = [];

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

// Buy Product
  final List<ProductModel> _buyProductList = [];
  List<ProductModel> get getBuyProductList => _buyProductList;

  void addBuyProduct(ProductModel product) {
    _buyProductList.add(product);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  // Total Price
  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.sluong!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.sluong!;
    }
    return totalPrice;
  }

  void updateSluong(ProductModel productModel, int sluong) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].sluong = sluong;
    notifyListeners();
  }
}
