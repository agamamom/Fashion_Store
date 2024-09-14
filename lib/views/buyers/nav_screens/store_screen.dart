import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/views/buyers/productDetail/store_detail_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> storesStream = FirebaseFirestore.instance
        .collection('vendors')
        .where('approved', isEqualTo: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: storesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.yellow.shade900,
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 80, left: 40),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Store Owners',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: ((context, index) {
                        final storeData = snapshot.data!.docs[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StoreDetailScreen(
                                    storeData: storeData,
                                  );
                                },
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              storeData['bussinessName'],
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(storeData['countryValue']),
                            leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(storeData['storeImage'])),
                          ),
                        );
                      })),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
