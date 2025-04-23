// import 'dart:ffi';

// import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore.dart';
// import 'package:ecommerce_app_user/models/order_model/order_model.dart';
// import 'package:flutter/material.dart';

// class OrderScreen extends StatefulWidget {
//   const OrderScreen({super.key});

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Đơn hàng của bạn",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestoreHelper.instance.getUserOrder(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.data!.isEmpty ||
//               snapshot.data == null ||
//               !snapshot.hasData) {
//             return const Center(
//               child: Text("Không có đơn hàng"),
//             );
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             padding:
//                 const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 70),
//             itemBuilder: (context, index) {
//               OrderModel orderModel = snapshot.data![index];
//               if (orderModel.products.isEmpty) return SizedBox();
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: ExpansionTile(
//                   tilePadding: EdgeInsets.zero,
//                   collapsedShape: const RoundedRectangleBorder(
//                     side: BorderSide(
//                       color: Colors.black,
//                       width: 2.3,
//                     ),
//                   ),
//                   shape: const RoundedRectangleBorder(
//                     side: BorderSide(
//                       color: Colors.black,
//                       width: 2.3,
//                     ),
//                   ),
//                   title: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.baseline,
//                       textBaseline: TextBaseline.alphabetic,
//                       children: [
//                         Container(
//                           height: 120,
//                           width: 120,
//                           color: Colors.grey.withOpacity(0.5),
//                           child: Image.network(orderModel.products[0].image!),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 orderModel.products[0].name,
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               orderModel.products.length > 1
//                                   ? Column(
//                                       children: [
//                                         Text(
//                                           "Số lượng: ${int.parse(orderModel.products.length.toString())}",
//                                           style: const TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 12),
//                                       ],
//                                     )
//                                   : SizedBox.fromSize(),
//                               Text(
//                                 "Tổng tiền: \$${orderModel.totalPrice.toString()}",
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 "Trạng thái: ${orderModel.status}",
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               orderModel.status == "Đang xử lý"
//                                   ? ElevatedButton(
//                                       onPressed: () async {
//                                         await FirebaseFirestoreHelper.instance
//                                             .updateOrder(orderModel, "Hủy");
//                                         orderModel.status = "Hủy";
//                                         setState(() {});
//                                       },
//                                       child: const Text(
//                                         "Hủy đơn hàng",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     )
//                                   : SizedBox.fromSize(),
//                               orderModel.status == "Đang vận chuyển" ||
//                                       orderModel.status == "Đang xử lý"
//                                   ? ElevatedButton(
//                                       onPressed: () {
//                                         FirebaseFirestoreHelper.instance
//                                             .updateOrder(
//                                                 orderModel, "Xác nhận");
//                                         orderModel.status = "Xác nhận";
//                                         setState(() {});
//                                       },
//                                       child: const Text(
//                                         "Đơn đã giao",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     )
//                                   : SizedBox.fromSize(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   children: orderModel.products.length > 1
//                       ? [
//                           const Text("Chi tiết"),
//                           const Divider(color: Colors.red),
//                           ...orderModel.products.map((singleProduct) {
//                             return SingleChildScrollView(
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 12.0, top: 6),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Container(
//                                           height: 80,
//                                           width: 80,
//                                           color: Colors.red.withOpacity(0.5),
//                                           child: Image.network(
//                                               singleProduct.image!),
//                                         ),
//                                         Expanded(
//                                           flex: 2,
//                                           child: SizedBox(
//                                             height: 140,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(12.0),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     singleProduct.name,
//                                                     style: const TextStyle(
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                   Column(
//                                                     children: [
//                                                       Text(
//                                                         "Số lượng: ${singleProduct.sluong.toString()}",
//                                                         style: const TextStyle(
//                                                           fontSize: 12,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 12),
//                                                     ],
//                                                   ),
//                                                   Text(
//                                                     "Giá tiền: \$${singleProduct.price.toString()}",
//                                                     style: const TextStyle(
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const Divider(color: Colors.red),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }).toList()
//                         ]
//                       : [],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:ecommerce_app_user/firebase/firebase_firestore_helper/firebase_firestore.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Đơn hàng của bạn",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có đơn hàng"));
          }

          return ListView.builder(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 70),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final orderModel = snapshot.data![index];
              if (orderModel.products.isEmpty) return const SizedBox();

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  tilePadding: const EdgeInsets.all(12),
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          orderModel.products[0].image ?? '',
                          height: 80,
                          width: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderModel.products[0].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Tổng tiền: \$${orderModel.totalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black87),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.inventory_2,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  "Số sản phẩm: ${orderModel.products.length}",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  orderModel.status == "Hủy"
                                      ? Icons.cancel
                                      : orderModel.status == "Xác nhận"
                                          ? Icons.check_circle
                                          : Icons.hourglass_bottom,
                                  color: orderModel.status == "Hủy"
                                      ? Colors.red
                                      : orderModel.status == "Xác nhận"
                                          ? Colors.green
                                          : Colors.orange,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Trạng thái: ${orderModel.status}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: [
                    ...orderModel.products.map((product) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product.image ?? '',
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 2),
                                  Text("Số lượng: ${product.sluong}",
                                      style: const TextStyle(fontSize: 12)),
                                  Text(
                                      "Giá: \$${product.price.toStringAsFixed(2)}",
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          if (orderModel.status == "Đang xử lý")
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  await FirebaseFirestoreHelper.instance
                                      .updateOrder(orderModel, "Hủy");
                                  orderModel.status = "Hủy";
                                  setState(() {});
                                },
                                child: const Text(
                                  "Hủy đơn hàng",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          if (orderModel.status == "Đang xử lý" ||
                              orderModel.status == "Đang vận chuyển")
                            const SizedBox(width: 8),
                          if (orderModel.status == "Đang xử lý" ||
                              orderModel.status == "Đang vận chuyển")
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  FirebaseFirestoreHelper.instance
                                      .updateOrder(orderModel, "Xác nhận");
                                  orderModel.status = "Xác nhận";
                                  setState(() {});
                                },
                                child: const Text(
                                  "Đơn đã giao",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
