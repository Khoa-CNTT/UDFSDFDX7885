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
}
