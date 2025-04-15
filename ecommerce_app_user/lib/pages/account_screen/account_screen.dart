import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/firebase/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:ecommerce_app_user/pages/favourite_screen/favourite_screen.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:ecommerce_app_user/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Tài khoản",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 120,
                      )
                    : CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                      ),
                Text(
                  appProvider.getUserInformation.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(appProvider.getUserInformation.email),
                const SizedBox(height: 12),
                SizedBox(
                  width: 160,
                  child: PrimaryButton(
                    title: "Sửa thông tin",
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Đơn hàng của bạn"),
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: FavouriteScreen(),
                      withNavBar: false,
                    );
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Sản phẩm yêu thích"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.info_outline),
                  title: const Text("Thông tin ứng dụng"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.support_agent_outlined),
                  title: const Text("Hỗ trợ khách hàng"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Đổi mật khẩu"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut(context);
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Đăng xuất"),
                ),
                const SizedBox(height: 12),
                const Text("Version 4.0.0")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
