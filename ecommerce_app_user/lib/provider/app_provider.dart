import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore.dart';
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
}
