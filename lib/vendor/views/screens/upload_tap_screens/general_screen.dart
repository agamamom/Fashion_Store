import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
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

  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormate.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Name';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(productName: value);
              },
              decoration:
                  const InputDecoration(labelText: 'Enter Product Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Price';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(productPrice: double.parse(value));
              },
              decoration:
                  const InputDecoration(labelText: 'Enter Product Price'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Quanity';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(quantity: int.parse(value));
              },
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
              onChanged: (value) {
                setState(() {
                  productProvider.getFormData(category: value);
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Description';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                productProvider.getFormData(description: value);
              },
              maxLines: 5,
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
                            lastDate: DateTime(5000))
                        .then(
                      (value) {
                        setState(() {
                          productProvider.getFormData(scheduleDate: value);
                        });
                      },
                    );
                  },
                  child: const Text('Schedule'),
                ),
                if (productProvider.productData['scheduleDate'] != null)
                  Text(
                    formatedDate(productProvider.productData['scheduleDate']),
                  )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
