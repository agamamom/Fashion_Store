import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/utils/show_snackBar.dart';

class VendorProductDetailScreen extends StatefulWidget {
  const VendorProductDetailScreen({super.key, this.productData});
  final dynamic productData;

  @override
  State<VendorProductDetailScreen> createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  @override
  void initState() {
    _productNameController.text = widget.productData['productName'];
    _brandNameController.text = widget.productData['brandName'];
    _quantityController.text = widget.productData['quantity'].toString();
    _productPriceController.text =
        widget.productData['productPrice'].toString();
    _productDescriptionController.text = widget.productData['description'];
    _categoryNameController.text = widget.productData['category'];
    super.initState();
  }

  double? productPrice;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          widget.productData['productName'],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _brandNameController,
              decoration: const InputDecoration(labelText: 'Brand Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                productQuantity = int.parse(value);
              },
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                productPrice = double.parse(value);
              },
              controller: _productPriceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLength: 800,
              maxLines: 3,
              controller: _productDescriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              enabled: false,
              controller: _categoryNameController,
              decoration: const InputDecoration(labelText: 'Category'),
            )
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () async {
          if (productPrice != null && productQuantity != null) {
            await _firestore
                .collection('products')
                .doc(widget.productData['productId'])
                .update({
              'productName': _productNameController.text,
              'brandName': _brandNameController.text,
              'quantity': productQuantity,
              'productPrice': productPrice,
              'description': _productDescriptionController.text,
              'category': _categoryNameController.text,
            });
          } else {
            showSnack(context, 'Update Quantity And Price');
          }
        },
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.yellow.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "UPDATE PRODUCT",
              style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
