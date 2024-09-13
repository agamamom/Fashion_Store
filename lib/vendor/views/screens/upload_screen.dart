import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_fashion_store/providers/product_provider.dart';
import 'package:multi_fashion_store/vendor/views/screens/main_vendor_screen.dart';
import 'package:multi_fashion_store/vendor/views/screens/upload_tap_screens/attributes_tab_screen.dart';
import 'package:multi_fashion_store/vendor/views/screens/upload_tap_screens/general_screen.dart';
import 'package:multi_fashion_store/vendor/views/screens/upload_tap_screens/images_tab_screen.dart';
import 'package:multi_fashion_store/vendor/views/screens/upload_tap_screens/shipping_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade900,
            bottom: const TabBar(tabs: [
              Tab(
                child: Text('General'),
              ),
              Tab(
                child: Text('Shipping'),
              ),
              Tab(
                child: Text('Attributes'),
              ),
              Tab(
                child: Text('Images'),
              ),
            ]),
          ),
          body: Column(
            children: [
              const Expanded(
                child: TabBarView(
                  children: [
                    GeneralScreen(),
                    ShippingScreen(),
                    AttributesTabScreen(),
                    ImagesTabScreen()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade900),
                  onPressed: () async {
                    EasyLoading.show(status: 'Please wait...');
                    if (_formKey.currentState!.validate()) {
                      final productId = const Uuid().v4();
                      await firestore.collection('products').doc(productId).set(
                        {
                          'productId': productId,
                          'productName':
                              productProvider.productData['productName'],
                          'productPrice':
                              productProvider.productData['productPrice'],
                          'quantity': productProvider.productData['quantity'],
                          'category': productProvider.productData['category'],
                          'description':
                              productProvider.productData['description'],
                          'imageUrl':
                              productProvider.productData['imageUrlList'],
                          'scheduleDate':
                              productProvider.productData['scheduleDate'],
                          'chargeShipping':
                              productProvider.productData['chargeShipping'],
                          'shippingCharge':
                              productProvider.productData['shippingCharge'],
                          'brandName': productProvider.productData['brandName'],
                          'sizeList': productProvider.productData['sizeList'],
                          'vendorId': FirebaseAuth.instance.currentUser!.uid,
                          'approved': false,
                        },
                      ).whenComplete(
                        () {
                          productProvider.clearData();
                          _formKey.currentState!.reset();
                          EasyLoading.dismiss();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const MainVendorScreen();
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
