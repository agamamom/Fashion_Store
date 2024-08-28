// import 'package:flutter/material.dart';
// import 'package:multi_fashion_store/providers/product_provider.dart';
// import 'package:multi_fashion_store/vendor/views/screens/upload_tap_screens/attributes_tab_screen.dart';
// import 'package:multi_fashion_store/vendor/views/screens/upload_tap_screens/general_screen.dart';
// import 'package:multi_fashion_store/vendor/views/screens/upload_tap_screens/images_tab_screen.dart';
// import 'package:multi_fashion_store/vendor/views/screens/upload_tap_screens/shipping_screen.dart';
// import 'package:provider/provider.dart';

// class UploadScreen extends StatelessWidget {
//   const UploadScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ProductProvider _productProvider =
//         Provider.of<ProductProvider>(context);
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.yellow.shade900,
//           bottom: const TabBar(tabs: [
//             Tab(
//               child: Text('General'),
//             ),
//             Tab(
//               child: Text('Shipping'),
//             ),
//             Tab(
//               child: Text('Attributes'),
//             ),
//             Tab(
//               child: Text('Images'),
//             ),
//           ]),
//         ),
//         body: TabBarView(
//           children: [
//             GeneralScreen(),
//             ShippingScreen(),
//             AttributesTabScreen(),
//             ImagesTabScreen()
//           ],
//         ),
//         bottomSheet: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.yellow.shade900),
//             onPressed: () {
//               _productProvider.productData['productName'];
//             },
//             child: const Text('Save'),
//           ),
//         ),
//       ),
//     );
//   }
// }
