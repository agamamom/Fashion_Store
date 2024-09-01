import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/widgets/home_products.dart';
import 'package:multi_fashion_store/views/buyers/nav_screens/widgets/main_products_widget.dart';

class CategoryText extends StatefulWidget {
  const CategoryText({Key? key}) : super(key: key);

  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Loading categories"),
                );
              }

              return SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final categoryData = snapshot.data!.docs[index];
                          return ActionChip(
                            backgroundColor: Colors.yellow.shade900,
                            onPressed: () {
                              setState(() {
                                _selectedCategory =
                                    categoryData['categoryName'];
                              });
                            },
                            label: Center(
                              child: Text(
                                categoryData['categoryName'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              );
            },
          ),
          if (_selectedCategory == null) const MainProductWidget(),
          if (_selectedCategory != null)
            HomeProductWidget(categoryName: _selectedCategory!),
        ],
      ),
    );
  }
}
