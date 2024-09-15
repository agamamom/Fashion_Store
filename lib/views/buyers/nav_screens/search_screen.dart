import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchedValue = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        elevation: 0,
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              _searchedValue = value;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Search for products',
            labelStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 4,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _searchedValue == ''
          ? const Center(
              child: Text(
                'Search for products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                final searchData = snapshot.data!.docs.where(
                  (element) {
                    return element['productName'].toLowerCase().contains(
                          _searchedValue.toLowerCase(),
                        );
                  },
                );

                return Column(
                  children: searchData.map(
                    (e) {
                      return Card(
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(e['imageUrl'][0]),
                            ),
                            Column(
                              children: [
                                Text(
                                  e['productName'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  e['productPrice'].toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow.shade900),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
    );
  }
}
