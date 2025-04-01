import 'package:flutter/material.dart';
import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ecommerce_app_user/models/category_model/category_model.dart';
import 'package:ecommerce_app_user/models/product_model/product_model.dart';
// import 'package:ecommerce_app_user/screens/product_detail/product_details.dart';

class CategoryScreen extends StatefulWidget {
  CategoryModel categoryModel;
  CategoryScreen({super.key, required this.categoryModel});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  Map<String, String> categoryTranslations = {
    "Phone": "Điện thoại",
    "Mouse": "Chuột",
    "Keyboard": "Bàn phím",
    "Headphone": "Tai nghe",
  };

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight * 0.8),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        const BackButton(),
                        Text(
                          categoryTranslations[widget.categoryModel.name] ??
                              widget.categoryModel.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Không có sản phẩm"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12),
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: productModelList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (ctx, index) {
                              ProductModel singleProduct =
                                  productModelList[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        singleProduct.image!,
                                        height: 100,
                                        width: 100,
                                      ),
                                      const SizedBox(height: 12.0),
                                      Text(
                                        singleProduct.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text("Giá: \$${singleProduct.price}"),
                                      const SizedBox(height: 12.0),
                                      SizedBox(
                                        height: 45,
                                        width: 140,
                                        child: OutlinedButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Mua ngay",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
