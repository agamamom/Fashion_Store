import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/providers/product_provider.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _categoryList = [];

  getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                _productProvider.getFormData(productName: value);
              },
              decoration:
                  const InputDecoration(labelText: 'Enter Product Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Enter Product Price'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter Product Quanity',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField(
              hint: const Text('Select Category'),
              items: _categoryList.map<DropdownMenuItem<String>>(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                },
              ).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 10,
              maxLength: 800,
              decoration: InputDecoration(
                labelText: 'Enter Product Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(5000));
                    },
                    child: const Text('Schedule'))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
