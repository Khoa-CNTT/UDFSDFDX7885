import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ecommerce_app_user/pages/category_screen/category_screen.dart';
import 'package:ecommerce_app_user/pages/chatbot_screen/chatbot_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_user/constants/routes.dart';
// import 'package:ecommerce_app_user/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:ecommerce_app_user/models/category_model/category_model.dart';
import 'package:ecommerce_app_user/models/product_model/product_model.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
// import 'package:ecommerce_app_user/screens/category_view/category_view.dart';
// import 'package:ecommerce_app_user/screens/chatbot_screen/chatbot_screen.dart';
// import 'package:ecommerce_app_user/screens/product_detail/product_details.dart';
import 'package:ecommerce_app_user/widgets/top_titles/top_titles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  final List<Map<String, String>> bannerImages = [
    {"image": "assets/images/phone_banner.png", "category": "Phone"},
    {"image": "assets/images/mouse_banner.png", "category": "Mouse"},
    {"image": "assets/images/keyboard_banner.png", "category": "Keyboard"},
    {"image": "assets/images/headphones_banner.png", "category": "Headphone"}
  ];

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
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
          : buildBody(),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopTitles(
                  title: "Chào mừng bạn",
                  subtitle: "Khám phá sản phẩm chất lượng",
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: search,
                  onChanged: (value) {
                    searchProducts(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Tìm kiếm sản phẩm...",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: search.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              search.clear();
                              searchProducts("");
                            },
                            icon: Icon(Icons.clear),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Them Slider
                chaySlider(),

                const SizedBox(height: 20),

                const Text(
                  "Danh mục",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          categoriesList.isEmpty
              ? const Center(
                  child: Text("Trống"),
                )
              : listCategory(),
          const SizedBox(height: 12),
          !isSearched()
              ? const Padding(
                  padding: EdgeInsets.only(top: 12, left: 12),
                  child: Text(
                    "Danh sách sản phẩm",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : SizedBox.fromSize(),
          search.text.isNotEmpty && searchList.isEmpty
              ? const Center(
                  child: Text("Không tìm thấy sản phẩm"),
                )
              : searchList.isNotEmpty
                  ? sanPhamTimKiem()
                  : productModelList.isEmpty
                      ? const Center(
                          child: Text("Không có sản phẩm nổi bật"),
                        )
                      : danhSachSanPham(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget chaySlider() {
    return CarouselSlider(
      items: bannerImages.map((imageUrl) {
        CategoryModel? category = categoriesList.firstWhere(
          (e) => e.name.toLowerCase() == imageUrl["category"]!.toLowerCase(),
          orElse: () => categoriesList.isNotEmpty
              ? categoriesList.first
              : CategoryModel(
                  id: "",
                  name: "Mặc định",
                  image: "",
                ),
        );
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryScreen(
                  categoryModel: category,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl["image"]!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 325,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
      ),
    );
  }

  Widget listCategory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoriesList
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: AnimatedContainer(
                  duration: Duration(microseconds: 200),
                  transform: Matrix4.identity()..scale(1.0),
                  child: GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                        widget: CategoryScreen(
                          categoryModel: e,
                        ),
                        context: context,
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(e.image),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget sanPhamTimKiem() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 50),
        shrinkWrap: true,
        primary: false,
        itemCount: searchList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (ctx, index) {
          ProductModel singleProduct = searchList[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    singleProduct.image!,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    singleProduct.name.length > 20
                        ? singleProduct.name.substring(0, 20) + "..."
                        : singleProduct.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Giá: \$${singleProduct.price}"),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "Mua ngay",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget danhSachSanPham() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 50),
        shrinkWrap: true,
        primary: false,
        itemCount: productModelList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (ctx, index) {
          ProductModel singleProduct = productModelList[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    singleProduct.image!,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    singleProduct.name.length > 20
                        ? singleProduct.name.substring(0, 20) + "..."
                        : singleProduct.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Giá: \$${singleProduct.price}"),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Mua ngay",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
